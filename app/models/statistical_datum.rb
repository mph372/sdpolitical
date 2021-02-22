class StatisticalDatum < ApplicationRecord
  belongs_to :district, optional: true
  belongs_to :jurisdiction, optional: true
  has_many :registration_snapshots

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

  def winner_2020
    biden_2020 - trump_2020
  end

  def winner_2018
    newsom_2018 - cox_2018
  end

  def winner_2016
    clinton_2016 - trump_2016
  end

  def winner_2014
    brown_2014 - kashkari_2014
  end

  def winner_2012
    obama_2012 - romney_2012
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

  def measure_a_result
    measure_a_yes.to_f / (measure_a_yes.to_f + measure_a_no.to_f) * 100
  end

  def prop_6_yes_result
    prop_6_yes.to_f / (prop_6_yes.to_f + prop_6_no.to_f) * 100
  end

  def prop_62_yes_result
    prop_62_yes.to_f / (prop_62_yes.to_f + prop_62_no.to_f) * 100
  end

  def prop_51_yes_result
    prop_51_yes.to_f / (prop_51_yes.to_f + prop_51_no.to_f) * 100
  end

  def prop_15_yes_result
    prop_15_yes.to_f / (prop_15_yes.to_f + prop_15_no.to_f) * 100
  end

  def prop_16_yes_result
    prop_16_yes.to_f / (prop_16_yes.to_f + prop_16_no.to_f) * 100
  end

  def prop_21_yes_result
    prop_21_yes.to_f / (prop_21_yes.to_f + prop_21_no.to_f) * 100
  end

  def prop_6_no_result
    prop_6_no.to_f / (prop_6_yes.to_f + prop_6_no.to_f) * 100
  end

  def prop_62_no_result
    prop_62_no.to_f / (prop_62_yes.to_f + prop_62_no.to_f) * 100
  end

  def prop_51_no_result
    prop_51_no.to_f / (prop_51_yes.to_f + prop_51_no.to_f) * 100
  end

  def prop_15_no_result
    prop_15_no.to_f / (prop_15_yes.to_f + prop_15_no.to_f) * 100
  end

  def prop_16_no_result
    prop_16_no.to_f / (prop_16_yes.to_f + prop_16_no.to_f) * 100
  end

  def prop_21_no_result
    prop_21_no.to_f / (prop_21_yes.to_f + prop_21_no.to_f) * 100
  end

  def prop_6_difference
    prop_6_yes_result - prop_6_no_result
  end

  def prop_62_difference
    prop_62_yes_result - prop_62_no_result
  end

  def prop_51_difference
    prop_51_yes_result - prop_51_no_result
  end

  def prop_15_difference
    prop_15_yes_result - prop_15_no_result
  end

  def prop_16_difference
    prop_16_yes_result - prop_16_no_result
  end

  def prop_21_difference
    prop_21_yes_result - prop_21_no_result
  end



end
