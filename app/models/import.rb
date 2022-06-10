class Import < ApplicationRecord
  belongs_to :candidate_committee, optional: :true
  belongs_to :committee, optional: :true 
  has_many :transactions, dependent: :destroy
end
