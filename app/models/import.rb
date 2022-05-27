class Import < ApplicationRecord
  belongs_to :candidate_committee
  has_many :transactions, dependent: :destroy
end
