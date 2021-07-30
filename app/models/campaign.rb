class Campaign < ApplicationRecord
  belongs_to :district
  has_many :candidates, dependent: :destroy 
  accepts_nested_attributes_for :candidates, allow_destroy: true, reject_if: :all_blank

  scope :active, -> {where('election_date >= ?', Date.today)}

  scope :historic, -> {where('election_date < ?', Date.today)}

end
