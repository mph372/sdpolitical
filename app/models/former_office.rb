class FormerOffice < ApplicationRecord
  has_one :district, optional: true 
  belongs_to :person
end
