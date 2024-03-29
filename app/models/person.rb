class Person < ApplicationRecord
  # belongs_to :district, inverse_of: :candidates, class_name: "District", optional: true
  # has_one :incumbent_district, inverse_of: :incumbent, class_name: "District", required: false, foreign_key: "incumbent_id"

  has_many :candidate_committees
  has_many :historical_candidate
  has_many :former_offices
  has_many :candidates
  has_many :campaigns, through: :candidates
  belongs_to :district, optional: true
  has_many :reports, through: :candidate_committees 

 
  def self.ransackable_attributes(auth_object = nil)
    %w[first_name last_name]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end

  
  has_many :reports do
    def most_recent
      order(report_filed: :desc).first
    end  
  end

  def campaign
    candidates.active.last.campaign
  end



  def person_is_candidate
    if candidates.where('active = ?', true).present?
      true
    else
      false
    end
  end



  def opponents
    campaign.candidates
  end

  def at_large_opponents
    campaign.district.jurisdiction
  end

  #@person.district.jurisdiction.candidates.each


#candidates: @district.campaigns.last.candidates.collect{|u| u.person}.flatten

  def campaign_district
    campaign.district
  end

  def retired
    if is_candidate == false && district.present? == false && former_offices.present?
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

  def birthday_unknown
    if calculated_age > 100
      true
    end
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

  def birthday_title
    if district.present?
      "#{district.district_title}, #{district.jurisdiction.name}"
    else
      "Candidate, #{candidates.active.last.campaign.district.full_district_name}"
    end
  end




  def is_candidate
    candidates.active.present?
  end

  def set_active
    if district.present? || candidates.where(active: true).present?
      if district.present?
        if district.jurisdiction.archived == true
          update_attribute(:active, false)
        end
      end
      if candidates.where(active: true).present?
        update_attribute(:active, false)
      end
    else
        update_attribute(:active, true)
    end
  end

  def incumbent_asterisk
    if is_incumbent == true && running_reelection == true
      "*"
    else
    end
  end

  def resides_in_present
    congressional_district != nil && senate_district != nil && assembly_district != nil && supe_district != nil
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





  def description    
      if district.present?
      "#{self.full_name} currently serves as #{self.district.district_title} for the #{self.district.jurisdiction.name}."
      end
  end

  

  def keywords
    "#{self.full_name}, #{}"
    if district.present?
      "#{self.full_name}, #{self.district.name}, #{self.district.jurisdiction.name} ."
    end
  end

  def incumbent_district
    district
  end

  def person_title
    if is_incumbent? 
      title 
    else
      professional_career
    end
  end

  def is_current_cycle
    reports.where(candidate_report: true).present? && (reports.where(:cycle => Admin.current_cycle).present?)
  end



  #before_save :update_birthdate_fields
  # before_save :update_district_field

  def most_recent_report
    candidate_committees.is_primary.last.reports.most_recent
  end

  def all_reports
    candidate_committees.find_by(primary_committee: true).reports
  end

  def has_reports
    if candidate_committees.empty?
      false
    elsif candidate_committees.find_by(:primary_committee => true).reports.present? 
      true
    end
  end

  def district_title
    if district.present?
      "#{district.district_title}, #{district.jurisdiction.name}"
    else
    end
  end
  
  private

  def update_birthdate_fields
    if birthdate_changed?
      self.birth_month = birthdate ? birthdate.month : nil
      self.birth_day = birthdate ? birthdate.day : nil
    end
  end

  
  #def update_district_field
   # if running_reelection == true
    #  self.district = self.incumbent_district
   # end
   # if running_reelection == false && is_incumbent == true && on_ballot == false
   #   self.district = nil
   # end
  #end

  def full_name_with_party
    "#{first_name} #{last_name} #{party_abbreviation}"
  end


end
