class Report < ApplicationRecord
  belongs_to :incumbent, optional: true
  belongs_to :candidate, optional: true
end
