class Committee < ApplicationRecord
  belongs_to :jurisdiction
  belongs_to :person, optional: true
  belongs_to :measure, optional: true
  has_many :reports
  has_many :expenditures
end
