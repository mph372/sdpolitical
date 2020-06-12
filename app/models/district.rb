class District < ApplicationRecord
  belongs_to :jurisdiction
  has_many :incumbents
  has_many :candidates
end
