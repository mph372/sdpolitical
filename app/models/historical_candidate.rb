class HistoricalCandidate < ApplicationRecord
  belongs_to :election_history, optional: true
  belongs_to :person, optional: true
  delegate :district, to: :election_history

  def vote_share
    calculation = (votes.to_f / election_history.total_votes) * 100
    "#{calculation.round(2)}%"
  end


end

