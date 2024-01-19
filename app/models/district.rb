class District < ApplicationRecord
  


  belongs_to :jurisdiction 
  # has_many :candidates, inverse_of: :district, class_name: 'Person'
  # belongs_to :incumbent, inverse_of: :incumbent_district, class_name: 'Person', foreign_key: 'incumbent_id', optional: true
  has_many :reports, through: :persons
  has_many :election_histories, dependent: :destroy 
  has_many :historical_candidates, through: :election_histories
  has_many :statistical_datum, dependent: :destroy
  has_many :registration_snapshots, through: :statistical_datum
  has_many :former_offices
  cattr_accessor :current_user
  has_many :campaigns, dependent: :destroy
  has_many :candidates, through: :campaigns
  has_one :person
  has_one :campaign_finance_module
  accepts_nested_attributes_for :person
  nilify_blanks only: [:person_id]
  mount_uploader :district_map, DistrictMapUploader


  def person_id=(new_person_id)
    return if new_person_id.blank?
    
    # Unlink current incumbent if different
    if incumbent_id != new_person_id
      Person.where(district_id: id).update_all(district_id: nil, archived: true)
    end

    # Link new incumbent
    Person.find_by(id: new_person_id).try(:update, district_id: id, archived: false)

    # Set the new incumbent_id
    self[:incumbent_id] = new_person_id
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name district term_expires number_of_winners district_title archived note] + _ransackers.keys
  end

  def self.ransackable_associations(auth_object = nil)
    [] # Specify any associations you want to include in search
  end
  

  def district_name
    if self.district != "At Large" 
      if self.at_large_district == false
     "#{self.name}, #{self.district.to_i.ordinalize} District"
     else
      "#{self.name}"
     end
    else
     "#{self.name}"
    end
  end

  def archived
    jurisdiction.archived == true
  end

  def incumbent_name
    if person.present?
      person.full_name
    else
      "Vacant"
    end
  end

  def incumbent
    person
  end

  def registration_advantage
    if is_at_large == true
      if jurisdiction.registration_snapshots.present?
        jurisdiction.registration_snapshots.last.registration_advantage
      else
        dem_voters - rep_voters
      end
    else
      if registration_snapshots.present?
        registration_snapshots.last.registration_advantage
      else
        dem_voters - rep_voters
      end
    end
  end

  def is_at_large
    at_large_district == true || district == "At Large"

  end





  def jurisdiction_district_name
    if self.district != "At Large" 
     "#{self.name} (#{self.district})"
    else
     "#{self.name}"
    end
  end

  def full_district_name
    "#{self.jurisdiction.name} - #{self.district_name}"
  end

  

  


  def description
    if person.present?
      "#{self.jurisdiction.name}, #{self.district_name} is currently represented by #{person.title} #{person.full_name}."
    else
      "#{self.jurisdiction.name}, #{self.district_name} is currently vacant."
    end
  end

  def keywords
    "#{self.jurisdiction.name}, #{self.district_name}"
  end

  def district_data
    if at_large_district? && self.jurisdiction.statistical_datum.present?
      true
    elsif statistical_datum.present? || jurisdiction.statistical_datum.present?
      true
    else
      false
    end
  end

  def latest_registration
    if is_at_large == true
    jurisdiction.statistical_datum.last.registration_snapshots.last
    else
    statistical_datum.last.registration_snapshots.last
    end
  end

  def true_statistical_datum
    if is_at_large == true
    jurisdiction.statistical_datum.last
    else
    statistical_datum.last
    end
  end
end
