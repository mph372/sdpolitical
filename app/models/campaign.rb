class Campaign < ApplicationRecord
  belongs_to :district
  has_many :candidates
  accepts_nested_attributes_for :candidates, allow_destroy: true, reject_if: :all_blank
end
