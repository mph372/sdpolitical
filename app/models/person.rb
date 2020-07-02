class Person < ApplicationRecord
  belongs_to :district, inverse_of: :candidates, class_name: "District", optional: true
  has_one :incumbent_district, inverse_of: :incumbent, class_name: "District", required: false, foreign_key: "incumbent_id"
  has_many :expenditures

  

  
  has_many :reports do
    def most_recent
      order(report_filed: :desc).first
    end

  
  end
  mount_uploader :image, IncumbentUploader

  def calculated_age
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  def calculated_tenure
    now = Time.now.utc.to_date
    now.year - first_elected.year - ((now.month > first_elected.month || (now.month == first_elected.month && now.day >= first_elected.day)) ? 0 : 1)
  end

  attr_accessor :incumbent_district_id
   after_validation :assign_district
   def assign_district
      return unless incumbent_district_id
      district = District.where(id: incumbent_district_id).first
      self.incumbent_district = district
   end

end
