class Committee < ApplicationRecord
  belongs_to :jurisdiction
  belongs_to :candidate, optional: true
  belongs_to :incumbent, optional: true
  belongs_to :measure, optional: true
  has_many :reports
end
