class Campaign < ApplicationRecord
  belongs_to :district
  # belongs_to :person
  has_many :candidates, dependent: :destroy 
  accepts_nested_attributes_for :candidates, allow_destroy: true, reject_if: :all_blank
  has_many :itemized_expenditures

  scope :active, -> { where('election_date >= ?', 30.days.ago) }

  scope :historic, -> { where('election_date < ?', 30.days.ago) }

end
