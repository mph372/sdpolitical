# app/models/contestant_update.rb
class ContestantUpdate < ApplicationRecord
    belongs_to :contestant
  
    validates :mail_ballots_votes, :vote_center_ballots_votes, :provisional_votes, :total_votes, :number_of_precincts, :precincts_reported, :ballots_cast, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
  