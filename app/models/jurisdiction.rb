class Jurisdiction < ApplicationRecord
    has_many :districts
    has_many :measures
    has_many :candidates, through: :districts
    has_many :expenditures, through: :districts
    has_many :incumbents, through: :districts
    has_many :committees
    belongs_to :registration_history, optional: true
end
