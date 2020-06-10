class District < ApplicationRecord
  belongs_to :jurisdiction
  has_many :incumbents
end
