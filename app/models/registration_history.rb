class RegistrationHistory < ApplicationRecord
  has_many :districts
  has_many :jurisdictions

  # 2012 Numbers
  def gop_2012_percent
    (gop_2012.to_f / total_2012.to_f) * 100
  end

  def dem_2012_percent
    (dem_2012.to_f / total_2012.to_f) * 100
  end

  def other_2012_percent
    (total_2012.to_f - (dem_2012.to_f + gop_2012.to_f)) / total_2012.to_f * 100
  end


  # 2014 Numbers

  def gop_2014_percent
    (gop_2014.to_f / total_2014.to_f) * 100
  end

  def dem_2014_percent
    (dem_2014.to_f / total_2014.to_f) * 100
  end

  def other_2014_percent
    (total_2014.to_f - (dem_2014.to_f + gop_2014.to_f)) / total_2014.to_f * 100
  end

  # 2016 Numbers

  def gop_2016_percent
    (gop_2016.to_f / total_2016.to_f) * 100
  end

  def dem_2016_percent
    (dem_2016.to_f / total_2016.to_f) * 100
  end

  def other_2016_percent
    (total_2016.to_f - (dem_2016.to_f + gop_2016.to_f)) / total_2016.to_f * 100
  end

  # 2018 Numbers

  def gop_2018_percent
    (gop_2018.to_f / total_2018.to_f) * 100
  end

  def dem_2018_percent
    (dem_2018.to_f / total_2018.to_f) * 100
  end

  def other_2018_percent
    (total_2018.to_f - (dem_2018.to_f + gop_2018.to_f)) / total_2018.to_f * 100
  end

  # 2020 Numbers

  def gop_2020_percent
    (gop_2020.to_f / total_2020.to_f) * 100
  end

  def dem_2020_percent
    (dem_2020.to_f / total_2020.to_f) * 100
  end

  def other_2020_percent
    (total_2020.to_f - (dem_2020.to_f + gop_2020.to_f)) / total_2020.to_f * 100
  end

  # Registration Advantage 2012

  def raw_registration_advantage_2012
    dem_2012_percent - gop_2012_percent
  end

  def registration_advantage_2012
    if raw_registration_advantage_2012 > 0
      "#{raw_registration_advantage_2012.truncate(2)}"
    else
      "#{raw_registration_advantage_2012.truncate(2)*-1}"
    end
  end

  # Registration Advantage 2014

  def raw_registration_advantage_2014
    dem_2014_percent - gop_2014_percent
  end

  def registration_advantage_2014
    if raw_registration_advantage_2014 > 0
      "#{raw_registration_advantage_2014.truncate(2)}"
    else
      "#{raw_registration_advantage_2014.truncate(2)*-1}"
    end
  end

  # Registration Advantage 2016

  def raw_registration_advantage_2016
    dem_2016_percent - gop_2016_percent
  end

  def registration_advantage_2016
    if raw_registration_advantage_2016 > 0
      "#{raw_registration_advantage_2016.truncate(2)}"
    else
      "#{raw_registration_advantage_2016.truncate(2)*-1}"
    end
  end

  # Registration Advantage 2018

  def raw_registration_advantage_2018
    dem_2018_percent - gop_2018_percent
  end

  def registration_advantage_2018
    if raw_registration_advantage_2018 > 0
      "#{raw_registration_advantage_2018.truncate(2)}"
    else
      "#{raw_registration_advantage_2018.truncate(2)*-1}"
    end
  end

    # Registration Advantage 2020

    def raw_registration_advantage_2020
      dem_2020_percent - gop_2020_percent
    end
  
    def registration_advantage_2020
      if raw_registration_advantage_2020 > 0
        "#{raw_registration_advantage_2020.truncate(2)}"
      else
        "#{raw_registration_advantage_2020.truncate(2)*-1}"
      end
    end

end
