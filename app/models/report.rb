class Report < ApplicationRecord
  belongs_to :incumbent, optional: true
  belongs_to :candidate, optional: true
  belongs_to :committee, optional: true
  delegate :district, to: :candidate 
  belongs_to :person
end
