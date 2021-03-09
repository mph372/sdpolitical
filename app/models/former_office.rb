class FormerOffice < ApplicationRecord
  belongs_to :district
  accepts_nested_attributes_for :district
  belongs_to :person

  
 
  

  def former_office_district
    District.find_by(district_id: district_id)
  end

end
