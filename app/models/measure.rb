class Measure < ApplicationRecord
  belongs_to :jurisdiction
  has_many :committees

  mount_uploader :pdf, MeasureUploader

end
