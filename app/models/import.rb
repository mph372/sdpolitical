class Import < ApplicationRecord
  belongs_to :candidate_committee
  has_many :transactions, dependent: :destroy
  has_many :reports, dependent: :destroy
end
