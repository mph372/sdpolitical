class Committee < ApplicationRecord
  belongs_to :jurisdiction
  belongs_to :candidate
  belongs_to :incumbent
  belongs_to :measure
end
