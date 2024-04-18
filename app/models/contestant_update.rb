# app/models/contestant_update.rb
class ContestantUpdate < ApplicationRecord
    belongs_to :contestant
  
    validates :mail_ballots_votes, :vote_center_ballots_votes, :provisional_votes, :total_votes, :number_of_precincts, :precincts_reported, :ballots_cast, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
 
    def previous_total_votes
      # Find the contestant's previous update by getting the updates before this one and picking the latest
      previous_update = contestant.contestant_updates.where("created_at < ?", self.created_at).order(created_at: :desc).first
      previous_update ? previous_update.total_votes : nil
    end


 
 
  end
  