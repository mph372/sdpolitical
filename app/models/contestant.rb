class Contestant < ApplicationRecord
  belongs_to :contest
  has_many :contestant_updates, -> { order(created_at: :desc) }, dependent: :destroy

  validates :name, presence: true

  def latest_update
    contestant_updates.first
  end

  def previous_update
    contestant_updates.second
  end

  def vote_change
    previous_update ? latest_update.total_votes - previous_update.total_votes : nil
  end

  def votes_behind
    contestants = contest.contestants.includes(:contestant_updates)
    sorted_contestants = contestants.sort_by { |c| c.latest_update&.total_votes || 0 }.reverse
    index = sorted_contestants.find_index(self)

    return nil if index.nil? || index.zero?

    sorted_contestants[index - 1].latest_update.total_votes - self.latest_update.total_votes
  end

  def latest_total_votes
    latest_update.total_votes
  end

  def vote_percentage
    total_votes_in_contest = self.contest.contestants.includes(:contestant_updates).sum do |contestant|
      contestant.contestant_updates.first.total_votes
    end

    (self.contestant_updates.first.total_votes.to_f / total_votes_in_contest) * 100
  end



  def needed_percentage_from_outstanding
    return nil unless votes_behind
  
    total_ballots_cast_in_election = contest.election.election_updates.last.ballots_cast
    total_outstanding_ballots = contest.election.election_updates.last.ballots_outstanding
    district_ballots_cast = latest_update.ballots_cast
  
    return nil if total_ballots_cast_in_election.zero? || total_outstanding_ballots.zero? || votes_behind.nil?
  
    district_proportion = district_ballots_cast.to_f / total_ballots_cast_in_election
    estimated_district_outstanding = total_outstanding_ballots * district_proportion
  
    return 0 if estimated_district_outstanding <= votes_behind
  
    # Adjust the calculation to find x, the number of votes Reichert needs from the outstanding votes
    # to ensure she surpasses Fletcher.
    # The formula is derived from Reichert's votes + x = Fletcher's votes + (remaining votes - x) + 1
    # Simplifying this gives x = (votes_behind + remaining votes + 1) / 2
    # This ensures she covers the gap and surpasses by at least one vote.
    x = (votes_behind + estimated_district_outstanding + 1) / 2.0
  
    # If x is greater than the estimated outstanding votes, it's impossible for Reichert to win.
    return nil if x > estimated_district_outstanding
  
    # Calculate the percentage of the estimated outstanding district ballots needed
    needed_percentage = (x.to_f / estimated_district_outstanding * 100).round(2)
  end
  
  
  
  
  
end
