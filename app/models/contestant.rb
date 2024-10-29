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
    return 0 unless contestant_updates.any?
    
    total_votes_in_contest = contest.contestants.includes(:contestant_updates).sum do |contestant|
        contestant.contestant_updates.first&.total_votes.to_i
    end
    
    return 0 if total_votes_in_contest.zero?
    
    (contestant_updates.first.total_votes.to_f / total_votes_in_contest) * 100
end



  def needed_percentage_or_status
    percentage = needed_percentage_from_outstanding
    
    if percentage.nil?
      "" # In first place or tied, leave blank
    elsif percentage == 0
      "Eliminated"
    else
      "#{percentage}%"
    end
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
    
    x = (votes_behind + estimated_district_outstanding + 1) / 2.0
    
    return 0 if x > estimated_district_outstanding
    
    (x.to_f / estimated_district_outstanding * 100).round(2)
  end
  
  
  def last_update_votes(vote_type)
    contestant_updates.where(vote_type: vote_type).order(:created_at).last&.total_votes || 0
  end

  # Gets the total votes of the last update before the first update of a given vote type
  def last_before_type_votes(vote_type)
    first_update_of_type = contestant_updates.where(vote_type: vote_type).order(:created_at).first
    return 0 unless first_update_of_type
    contestant_updates.where("created_at < ?", first_update_of_type.created_at).order(:created_at).last&.total_votes || 0
  end

  # Calculates the incremental votes for a given vote type
  def incremental_votes(vote_type)
    last_update_votes(vote_type) - last_before_type_votes(vote_type)
  end

  # Updates the vote_percentage method to use incremental_votes
  def vote_type_percentage(vote_type, total)
    incremental_vote = incremental_votes(vote_type)
    return 0 unless total.positive?
    (incremental_vote.to_f / total * 100).round(2)
  end

  def incremental_votes(vote_type)
    last_update = contestant_updates.where(vote_type: vote_type).order(created_at: :desc).first
    last_different_type_update = contestant_updates.where.not(vote_type: vote_type).where("created_at < ?", last_update.created_at).order(created_at: :desc).first if last_update

    last_update_votes = last_update&.total_votes || 0
    last_different_type_votes = last_different_type_update&.total_votes || 0

    last_update_votes - last_different_type_votes
  end

  def display_incremental_votes(vote_type, total_votes)
    incremental_votes = self.incremental_votes(vote_type)
    if incremental_votes > 0
      {
        votes: incremental_votes,
        percentage: self.vote_type_percentage(vote_type, total_votes)
      }
    else
      {
        votes: '-',
        percentage: '-'
      }
    end
  end

  def position_rank
    contest.contestants
           .sort_by { |c| -c.contestant_updates.first.total_votes }
           .index(self) + 1
  end
  
  
end
