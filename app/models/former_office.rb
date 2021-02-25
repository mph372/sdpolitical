class FormerOffice < ApplicationRecord
  has_one :district
  belongs_to :person

  def former_office_district
    District.find_by(district_id: district_id)
  end

end
