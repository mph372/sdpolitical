# app/models/election.rb
class Election < ApplicationRecord
    has_many :election_updates, dependent: :destroy
    has_many :contests, dependent: :destroy

  
    validates :name, presence: true
    validates :election_date, presence: true

    extend FriendlyId
    friendly_id :formatted_election_date, use: :slugged

    def formatted_election_date
      election_date.strftime('%Y-%m-%d') if election_date
    end

    def should_generate_new_friendly_id?
      election_date_changed? || super
    end
  end
  