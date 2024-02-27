# app/models/contestant.rb
class Contestant < ApplicationRecord
    belongs_to :contest
    has_many :contestant_updates, dependent: :destroy
  
    validates :name, presence: true
    validates :party, presence: true
  end
  