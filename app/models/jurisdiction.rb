class Jurisdiction < ApplicationRecord
    has_many :districts
    has_many :measures
    has_many :candidates, through: :districts
    has_many :expenditures, through: :districts
    has_many :incumbents, through: :districts
    has_many :reports, through: :candidates
    has_many :committees
    has_many :election_histories, through: :districts 
    belongs_to :registration_history, optional: true
    has_many :statistical_datum
end
