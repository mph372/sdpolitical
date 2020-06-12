class Candidate < ApplicationRecord
  belongs_to :district
  has_many :reports
end
