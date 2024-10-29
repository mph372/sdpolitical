# app/models/contest.rb
class Contest < ApplicationRecord
    belongs_to :election
    has_many :contestants, dependent: :destroy
    has_many :contestant_updates, through: :contestants
    has_many :pinned_contests, dependent: :destroy
    has_many :pinning_users, through: :pinned_contests, source: :user

    extend FriendlyId
    friendly_id :name, use: :slugged
  
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

    def total_votes_for_type(vote_type)
      contestants.sum { |contestant| contestant.incremental_votes(vote_type) }
    end
  
    def total_early_votes
      total_votes_for_type('early_vote')
    end
  
    def total_election_day_votes
      total_votes_for_type('election_day_vote')
    end
  
    def total_late_votes
      total_votes_for_type('late_vote')
    end

    def pinned_by?(user)
      return false unless user
      pinning_users.include?(user)
    end

  end
  