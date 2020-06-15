class Report < ApplicationRecord
  belongs_to :committee, optional: true
  delegate :district, to: :person
  belongs_to :person, optional: true
end
