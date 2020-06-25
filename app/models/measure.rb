class Measure < ApplicationRecord
  belongs_to :jurisdiction
  has_many :committees
end
