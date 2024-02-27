# app/models/election_update.rb
class ElectionUpdate < ApplicationRecord
    belongs_to :election
  
    validates :ballots_cast, :mail_ballots, :vote_center_ballots, :registered_voters, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  end
  