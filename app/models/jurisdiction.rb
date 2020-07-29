class Jurisdiction < ApplicationRecord
    has_many :districts
    has_many :measures
    has_many :candidates, through: :districts
    has_many :incumbents, through: :districts
    has_many :committees
end
