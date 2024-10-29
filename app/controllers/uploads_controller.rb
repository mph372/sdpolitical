class UploadsController < ApplicationController
  require 'csv'

  def create
    election = Election.friendly.find(params[:election_slug])
    logger.debug "Processing upload for Election ID: #{election.id}"
    vote_type = params[:vote_type]

    # Track contests that need vote_for values (only for new contests)
    contests_without_vote_for = []
    contest_vote_for_values = {}

    logger.debug "=== Starting First Pass ==="
    
    # Read the CSV content and find the header row
    csv_content = File.read(params[:file].path)
    csv_rows = csv_content.split("\n")

    # Find the index of the row that starts with "Contest Name"
    header_row_index = csv_rows.find_index { |row| row.start_with?("Contest Name") }

    if header_row_index.nil?
      raise "Could not find header row starting with 'Contest Name'"
    end

    # Use the header row and all subsequent rows
    actual_csv_content = ([csv_rows[header_row_index]] + csv_rows[(header_row_index + 1)..-1]).join("\n")

    begin
      # First pass: collect vote_for values and check which contests are new
      existing_contest_names = election.contests.pluck(:name)
      
      CSV.parse(actual_csv_content, headers: true) do |row|
        contest_name = row['Contest Name']
        vote_for = row['Vote For'].presence&.to_i

        # Only collect vote_for if this is a new contest
        if !existing_contest_names.include?(contest_name) && vote_for
          contest_vote_for_values[contest_name] = vote_for
        end
      end

      # Second pass: create/update records
      CSV.parse(actual_csv_content, headers: true) do |row|
        contest_name = row['Contest Name']
        candidate_name = row['Candidate Name']
        party = row['Party'].presence

        # Only check for vote_for if this is a new contest
        if !existing_contest_names.include?(contest_name) && !contest_vote_for_values[contest_name]
          contests_without_vote_for << contest_name unless contests_without_vote_for.include?(contest_name)
          next
        end

        contest = Contest.find_or_create_by!(
          name: contest_name, 
          election: election
        ) do |c|
          c.vote_for = contest_vote_for_values[contest_name]
        end

        contestant = Contestant.find_or_create_by!(
          name: candidate_name, 
          contest: contest
        ) do |c|
          c.party = party
        end

        ContestantUpdate.create!(
          mail_ballots_votes: row['Mail Ballots Votes'].to_i,
          vote_center_ballots_votes: row['Vote Center Ballots Votes'].to_i,
          provisional_votes: row['Provisional Votes'].to_i,
          total_votes: row['Total Votes'].to_i,
          number_of_precincts: row['Number Of Precincts'].to_i,
          precincts_reported: row['Precincts Reported'].to_i,
          ballots_cast: row['Ballots Cast'].to_i,
          contestant: contestant,
          vote_type: vote_type
        )
      end

      if contests_without_vote_for.any?
        # Truncate the error message if it's too long
        contest_list = contests_without_vote_for.first(5).join(', ')
        contest_list += "... and #{contests_without_vote_for.size - 5} more" if contests_without_vote_for.size > 5
        redirect_to election, alert: "Missing 'Vote For' values for new contests: #{contest_list}"
      else
        redirect_to election, notice: 'Upload successful'
      end

    rescue StandardError => e
      logger.error "Upload failed: #{e.message}"
      logger.error "Backtrace: #{e.backtrace[0..5].join("\n")}"  # Show first 6 lines of backtrace
      
      error_message = case e
      when CSV::MalformedCSVError
        "CSV file appears to be malformed. Please check the file format."
      when ActiveRecord::RecordInvalid
        "Data validation failed: #{e.message}"
      else
        "Error details: #{e.message}"
      end
      
      redirect_to election, alert: "Upload failed: #{error_message}"
    end
  end
end