class District < ApplicationRecord
  


  belongs_to :jurisdiction 
  has_many :candidates, inverse_of: :district, class_name: 'Person'
  belongs_to :incumbent, inverse_of: :incumbent_district, class_name: 'Person', foreign_key: 'incumbent_id', optional: true
  has_many :reports, through: :persons
  belongs_to :user, optional: true
  has_many :dashboards
  has_many :added_districts, through: :dashboards, source: :user
  has_many :expenditures
  acts_as_followable

  
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
end
