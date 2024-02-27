# app/models/contest.rb
class Contest < ApplicationRecord
    belongs_to :election
    has_many :contestants, dependent: :destroy
  
    validates :name, presence: true
  end
  