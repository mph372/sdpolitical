class UploadsController < ApplicationController
  require 'csv'

  def create
    election = Election.find(params[:election_id])
    logger.debug "Processing upload for Election ID: #{election.id}"

    CSV.foreach(params[:file].path, headers: true, encoding: 'bom|utf-8') do |row|
      contest_name = row['Contest Name']
      candidate_name = row['Candidate Name']
      party = row['Party'].presence

      # Find or create the contest
      contest = Contest.find_or_create_by!(name: contest_name, election: election)
      logger.debug "Contest '#{contest_name}': #{contest.persisted? ? 'found' : 'created'}."

      # Find or create the contestant without defaulting to 'N/A' for party
      contestant = Contestant.find_or_create_by!(name: candidate_name, contest: contest) do |c|
        c.party = party
      end
      logger.debug "Contestant '#{candidate_name}': #{contestant.persisted? ? 'found' : 'created'}."

      # Always create a new contestant update
      contestant_update_attributes = {
        mail_ballots_votes: row['Mail Ballots Votes'].to_i,
        vote_center_ballots_votes: row['Vote Center Ballots Votes'].to_i,
        provisional_votes: row['Provisional Votes'].to_i,
        total_votes: row['Total Votes'].to_i,
        number_of_precincts: row['Number Of Precincts'].to_i,
        precincts_reported: row['Precincts Reported'].to_i,
        ballots_cast: row['Ballots Cast'].to_i,
        contestant: contestant
      }

      ContestantUpdate.create!(contestant_update_attributes)
      logger.debug "Created new update for contestant '#{candidate_name}'."
    end

    redirect_to election, notice: 'Spreadsheet uploaded successfully.'
    logger.debug "Upload complete for Election ID: #{election.id}"
  rescue => e
    logger.error "Upload failed for Election ID: #{election.id} with error: #{e.message}"
    redirect_to election, alert: 'Spreadsheet upload failed.'
  end
end
