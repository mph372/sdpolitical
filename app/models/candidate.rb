class Candidate < ApplicationRecord
  belongs_to :campaign
  belongs_to :person
end
