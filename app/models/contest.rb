# app/models/contest.rb
class Contest < ApplicationRecord
    belongs_to :election
    has_many :contestants, dependent: :destroy
  
    validates :name, presence: true


    def estimated_district_outstanding
      total_ballots_cast_in_election = self.election.election_updates.last.ballots_cast
      total_outstanding_ballots = self.election.election_updates.last.ballots_outstanding
      # Assuming there's at least one contestant with updates to determine district ballots cast
      district_ballots_cast = self.contestants.first.contestant_updates.first.ballots_cast

      return nil if total_ballots_cast_in_election.zero?

      district_proportion = district_ballots_cast.to_f / total_ballots_cast_in_election
      (total_outstanding_ballots * district_proportion).round
    end

    def ballots_cast
      self.contestants.first.contestant_updates.first.ballots_cast
    end

  end
  