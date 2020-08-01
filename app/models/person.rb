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

  def next_birthday
    calculated_age + 1
  end

  def calculated_tenure
    now = Time.now.utc.to_date
    now.year - first_elected.year - ((now.month > first_elected.month || (now.month == first_elected.month && now.day >= first_elected.day)) ? 0 : 1)
  end


  def former_candidate
    ballot_status == "Withdrew" || ballot_status == "Lost in Primary"
  end

  def is_candidate
    on_ballot == true || running_reelection == true
  end

  before_save :update_birthdate_fields
  before_save :update_district_field

  private

  def update_birthdate_fields
    if birthdate_changed?
      self.birth_month = birthdate ? birthdate.month : nil
      self.birth_day = birthdate ? birthdate.day : nil
    end
  end

  
  def update_district_field
    if running_reelection == true
      self.district = self.incumbent_district
    end
    if running_reelection == false && is_incumbent == true && on_ballot == false
      self.district = nil
    end
  end

end
