class ElectionHistory < ApplicationRecord
  belongs_to :district
  has_many :historical_candidates, dependent: :destroy
  accepts_nested_attributes_for :historical_candidates, allow_destroy: true, reject_if: :all_blank


end

