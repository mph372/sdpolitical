class Person < ApplicationRecord
  belongs_to :district, inverse_of: :candidates, class_name: "District", optional: true
  has_one :incumbent_district, inverse_of: :incumbent, class_name: "District", required: false, foreign_key: "incumbent_id"
  has_many :expenditures
  has_many :committees
 


  
  has_many :reports do
    def most_recent
      order(report_filed: :desc).first
    end



  
  end

  def self.to_csv
    CSV.generate do |csv|
        csv << column_names
        all.each do |candidate|
            csv << candidate.attributes.values_at(*column_name)
        end
    end
  end

  mount_uploader :image, IncumbentUploader

  def full_name
    first_name + " " + last_name
  end

  def district_name
    if self.district.district != "At Large" 
    puts "#{self.district.jurisdiction.name} - #{self.district.name}, #{self.district.district.to_i.ordinalize} District"
    else
    puts "#{self.district.jurisdiction.name} - #{self.district.name}"
    end
  end




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

  def current_cash_on_hand
    if self.reports.where(:cycle => "2020", candidate_report: true ).present?
      return self.reports.where(:cycle => "2020", candidate_report: true ).order('period_end DESC').first.current_coh
    else
      return "0.00"
    end
  end

  def current_net_coh
    if self.reports.where(:cycle => "2020", candidate_report: true ).present?
      return self.reports.where(:cycle => "2020", candidate_report: true ).order('period_end DESC').first.net_coh
    else
      return "0.00"
    end
  end

  def period_end
    if self.reports.where(:cycle => "2020", candidate_report: true ).present?
      return self.reports.where(candidate_report: true).order(:period_end).last.period_end.strftime("%m/%d/%Y")
    else
      return "No Reports"
    end
  end

  def incumbent_district_display
    if self.incumbent_district != "At Large" && self.incumbent_district.is_seat == false && self.incumbent_district.is_area == false 
     "- #{self.incumbent_district.district.to_i.ordinalize} District" 
    elsif self.incumbent_district.is_seat 
     "- Seat #{self.incumbent_district.district}"
    elsif self.incumbent_district.is_area 
     "- Trustee Area #{self.incumbent_district.district}"
    end
  end
  
  def is_birth_month
    self.birth_day >= Time.zone.now.day.to_i
  end

  def party_abbreviation
    if self.party == "Republican"
      "(R)"
    elsif self.party == "Democrat"
      "(D)"
    elsif self.party == "Declined to State"
      "(DTS)"
    elsif self.party == "Green"
      "(GREEN)"
    elsif self.party == "Peace & Freedom"
      "(P & F)"
    elsif self.party == "Libertarian"
      "(LIB)"
    elsif self.party == "Reform"
      "(REF)"
    elsif self.party == "Natural Law"
      "(NL)"
    elsif self.party == "American Independent"
      "(AIP)"      
    else
      "(Unknown)"    
    end
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
