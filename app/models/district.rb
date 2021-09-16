class District < ApplicationRecord
  


  belongs_to :jurisdiction 
  # has_many :candidates, inverse_of: :district, class_name: 'Person'
  # belongs_to :incumbent, inverse_of: :incumbent_district, class_name: 'Person', foreign_key: 'incumbent_id', optional: true
  has_many :reports, through: :persons
  has_many :election_histories
  has_many :historical_candidates, through: :election_histories
  has_many :statistical_datum
  has_many :registration_snapshots, through: :statistical_datum
  belongs_to :registration_history, optional: true
  has_many :former_offices
  acts_as_followable
  cattr_accessor :current_user
  has_many :campaigns
  has_many :candidates, through: :campaigns
  has_one :person
  has_one :campaign_finance_module
  accepts_nested_attributes_for :person
  nilify_blanks only: [:person_id]
  

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

  def is_at_large
    at_large_district == true || district == "At Large"

  end

  def user_following
    if current_user.following?(self)
      true
    end
  end

  def tracked_district
    if user_following
      true
    end
    if self.at_large_district? 
      @districts = self.jurisdiction.districts.all
      if @districts.any? { |district| district.user_following == true }
        true
      end
    end
  end



  def district_followers
    if self.followers.count == 0
      "Nobody is tracking this district"
    elsif self.followers.count == 1
      "One person is tracking this district"
    else
      "#{self.followers.count} people are tracking this district"
    end
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

  def gov_2018_result
    if self.newsom_percent.present?
      if self.gov_2018 > 0
          "Newsom +#{self.gov_2018.abs.truncate(2)}%" 
      else
          "Cox +#{self.gov_2018.abs.truncate(2)}%"
      end
    else
      "N/A"
    end
  end

  def pres_2016_result
    if self.clinton_percent.present?
      if self.pres_2016 > 0
          "Clinton +#{self.pres_2016.abs.truncate(2)}%" 
      else
          "Trump +#{self.pres_2016.abs.truncate(2)}%"
      end
    else
      "N/A"
    end
  end
  
  def gov_2014_result
    if self.brown_percent.present?
      if self.gov_2014 > 0
          "Brown +#{self.gov_2014.abs.truncate(2)}%" 
      else
          "Kashkari +#{self.gov_2014.abs.truncate(2)}%"
      end
    else
      "N/A"
    end
  end

  def pres_2012_result
    if self.obama_percent.present?
      if self.pres_2012 > 0
          "Obama +#{self.pres_2012.abs.truncate(2)}%" 
      else
          "Romney +#{self.pres_2012.abs.truncate(2)}%"
      end
    else
      "N/A"
    end
  end

  


  def contribution_limit_output
    if self.contribution_limit == 0 || self.contribution_limit == nil
       "No Limit"
    else
       "$#{self.contribution_limit}"
    end
  end

  def corporate_contribution_output
    if self.corporate_contributions?
       "Allowed"
    else
       "Prohibited"
    end
  end

  def party_contribution_limit_output
    if self.party_contribution_limit == 0 || self.party_contribution_limit == nil
       "No Limit"
    else
         "$#{self.party_contribution_limit}"
    end
  end

  def pac_contribution_output
    if self.pac_contributions?
       "Allowed"
    else
         "Prohibited"
    end
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

  def absolute_registration_advantage
    registration_advantage*-1
  end

  def gov_2018
    newsom_percent - cox_percent
  end

  def pres_2016
    clinton_percent - trump_percent
  end

  def gov_2014
    brown_percent - kashkari_percent
  end

  def pres_2012
    obama_percent - romney_percent
  end

  def dem_voters
    if statistical_datum.present? && statistical_datum.last.registration_snapshots.present?
      statistical_datum.last.registration_snapshots.last.democrat_percentage
    else
      (dem_percent / total_voters) * 100
    end
  end

  def truncated_dem_voters
    if is_at_large == true
      if jurisdiction.registration_snapshots.present?
        jurisdiction.registration_snapshots.last.democrat_percentage
      else
        dem_voters
      end
    else
      if registration_snapshots.present?
        registration_snapshots.last.democrat_percentage
      else
        dem_voters
      end
    end
  end

  def truncated_rep_voters
    if is_at_large == true
      if jurisdiction.registration_snapshots.present?
        jurisdiction.registration_snapshots.last.republican_percentage
      else
        rep_voters
      end
    else
      if registration_snapshots.present?
        registration_snapshots.last.republican_percentage
      else
        rep_voters
      end
    end
  end

  def rep_voters
    if statistical_datum.present? && statistical_datum.last.registration_snapshots.present?
      statistical_datum.last.registration_snapshots.last.republican_percentage
    else
    (rep_percent / total_voters) * 100
    end
  end

  def other_voters
    (total_voters - (dem_percent+rep_percent)) / total_voters * 100
  end

  def user_add_to_dashboard?
    user.dashboards.where(user: user, district: @district).any?
  end

  def measure_a_result
    measure_a_yes.to_f / (measure_a_yes.to_f + measure_a_no.to_f) * 100
  end

  def prop_6_result
    prop_6_yes.to_f / (prop_6_yes.to_f + prop_6_no.to_f) * 100
  end

  def prop_62_result
    prop_62_yes.to_f / (prop_62_yes.to_f + prop_62_no.to_f) * 100
  end

  def prop_51_result
    prop_51_yes.to_f / (prop_51_yes.to_f + prop_51_no.to_f) * 100
  end

  def turnout_2020
    (voted_2020.to_f / registered_2020.to_f) * 100
  end

  def turnout_2018
    (voted_2018.to_f / registered_2018.to_f) * 100
  end

  def turnout_2016
    (voted_2016.to_f / registered_2016.to_f) * 100
  end

  def turnout_2014
    (voted_2014.to_f / registered_2014.to_f) * 100
  end

  def turnout_2012
    (voted_2012.to_f / registered_2012.to_f) * 100
  end

  def average_turnout
    (turnout_2018 + turnout_2016 + turnout_2014 + turnout_2012) / 4
  end

  def measure_a_difference
    measure_a_result - 49.03
  end

  def prop_6_difference
    prop_6_result - 43.18
  end

  def prop_62_difference
    prop_62_result - 46.85
  end

  def prop_51_difference
    prop_51_result - 55.18
  end

  def performance_eligible
    if newsom_percent.present? || obama_percent.present? || brown_percent.present? || clinton_percent.present?
      return true
    end
  end

  def average_turnout_eligible
    if voted_2018.present? && voted_2014.present? && voted_2016.present? && voted_2012.present?
      return true 
    end
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
