class District < ApplicationRecord
  


  belongs_to :jurisdiction 
  has_many :candidates, inverse_of: :district, class_name: 'Person'
  belongs_to :incumbent, inverse_of: :incumbent_district, class_name: 'Person', foreign_key: 'incumbent_id', optional: true
  has_many :reports, through: :persons
  has_many :expenditures
  acts_as_followable

  def district_name
    if self.district != "At Large" 
     "#{self.name}, #{self.district.to_i.ordinalize} District"
    else
     "#{self.name}"
    end
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
    dem_voters - rep_voters
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
    (dem_percent / total_voters) * 100
  end

  def rep_voters
    (rep_percent / total_voters) * 100
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
end
