class Measure < ApplicationRecord
  belongs_to :jurisdiction
  has_many :committees
  has_many :expenditures

  mount_uploader :pdf, MeasureUploader



end
