class Jurisdiction < ApplicationRecord
    has_many :districts
    has_many :measures
end
