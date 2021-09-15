class FormerOffice < ApplicationRecord
  belongs_to :district, optional: true
  belongs_to :jurisdiction, optional: true
  accepts_nested_attributes_for :district
  belongs_to :person

  
 
  

  def former_office_district
    District.find_by(district_id: district_id)
  end

  def header_former_office_name
    if at_large == true
      "#{district.jurisdiction.name} - #{district.district_name}"
    else
      "#{district.full_district_name}"
    end
  end

  def true_former_office
    if at_large == true
     district.jurisdiction
    else
     district
    end
  end
end
