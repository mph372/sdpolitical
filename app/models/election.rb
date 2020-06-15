class Election < ApplicationRecord
  belongs_to :district

  has_many :persons
end
