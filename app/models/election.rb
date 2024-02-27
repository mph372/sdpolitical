# app/models/election.rb
class Election < ApplicationRecord
    has_many :election_updates, dependent: :destroy
    has_many :contests, dependent: :destroy
  
    validates :name, presence: true
    validates :election_date, presence: true
  end
  