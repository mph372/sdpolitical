class UploadsController < ApplicationController
  require 'csv'

  def create
    election = Election.friendly.find(params[:election_slug])
    logger.debug "Processing upload for Election ID: #{election.id}"
    vote_type = params[:vote_type]

    # Track contests that need vote_for values
    contests_without_vote_for = Set.new
    contest_vote_for_values = {}

    logger.debug "=== Starting First Pass ==="
    
    # Read the CSV content and skip the first 2 rows
    csv_content = File.read(params[:file].path)
    csv_rows = csv_content.split("\n")
    actual_csv_content = ([csv_rows[2]] + csv_rows[3..-1]).join("\n")

    # First pass: collect vote_for values
    CSV.parse(actual_csv_content, headers: true) do |row|
      contest_name = row['Contest Name']
      vote_for = row['Vote For'].presence&.to_i

      logger.debug "Checking row - Contest: #{contest_name}, Vote For: #{vote_for.inspect}"

      if vote_for
        contest_vote_for_values[contest_name] = vote_for
        logger.debug "Found Vote For value #{vote_for} for contest #{contest_name}"
      end
    end

    logger.debug "=== First Pass Complete ==="
    logger.debug "Vote For values found: #{contest_vote_for_values.inspect}"

    # Second pass: create/update records
    CSV.parse(actual_csv_content, headers: true) do |row|
      contest_name = row['Contest Name']
      candidate_name = row['Candidate Name']
      party = row['Party'].presence

      logger.debug "Processing row - Contest: #{contest_name}, Candidate: #{candidate_name}"

      # Check if we have a vote_for value for this contest
      unless contest_vote_for_values[contest_name]
        logger.debug "No Vote For value found for contest #{contest_name}"
        contests_without_vote_for.add(contest_name)
        next
      end

      # Find or create the contest with vote_for value
      contest = Contest.find_or_create_by!(
        name: contest_name, 
        election: election
      ) do |c|
        c.vote_for = contest_vote_for_values[contest_name]
        logger.debug "Setting vote_for to #{contest_vote_for_values[contest_name]} for new contest #{contest_name}"
      end
      
      # Update vote_for even if contest existed
      contest.update!(vote_for: contest_vote_for_values[contest_name]) unless contest.vote_for.present?
      
      logger.debug "Contest '#{contest_name}': #{contest.persisted? ? 'found' : 'created'}, vote_for: #{contest.vote_for}"

      # Find or create the contestant without defaulting to 'N/A' for party
      contestant = Contestant.find_or_create_by!(
        name: candidate_name, 
        contest: contest
      ) do |c|
        c.party = party
      end
      logger.debug "Contestant '#{candidate_name}': #{contestant.persisted? ? 'found' : 'created'}"

      # Create contestant update
      contestant_update_attributes = {
        mail_ballots_votes: row['Mail Ballots Votes'].to_i,
        vote_center_ballots_votes: row['Vote Center Ballots Votes'].to_i,
        provisional_votes: row['Provisional Votes'].to_i,
        total_votes: row['Total Votes'].to_i,
        number_of_precincts: row['Number Of Precincts'].to_i,
        precincts_reported: row['Precincts Reported'].to_i,
        ballots_cast: row['Ballots Cast'].to_i,
        contestant: contestant,
        vote_type: vote_type
      }

      ContestantUpdate.create!(contestant_update_attributes)
      logger.debug "Created new update for contestant '#{candidate_name}'"
    end

    if contests_without_vote_for.any?
      error_message = "Could not create the following contests because 'Vote For' value was missing: #{contests_without_vote_for.to_a.join(', ')}"
      logger.error error_message
      redirect_to election, alert: error_message
    else
      logger.debug "Upload successful - all contests had Vote For values"
      redirect_to election, notice: 'Spreadsheet uploaded successfully.'
    end
    logger.debug "Upload complete for Election ID: #{election.id}"

  rescue => e
    logger.error "Upload failed. Error: #{e.message}"
    logger.error e.backtrace.join("\n")
    if election
      redirect_to election_path(election), alert: "Spreadsheet upload failed: #{e.message}"
    else
      redirect_to election, alert: 'Election not found.'
    end
  end
end