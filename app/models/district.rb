class District < ApplicationRecord
  


  belongs_to :jurisdiction 
  has_many :candidates, inverse_of: :district, class_name: 'Person'
  belongs_to :incumbent, inverse_of: :incumbent_district, class_name: 'Person', foreign_key: 'incumbent_id', optional: true
  has_many :reports, through: :persons
  def registration_advantage
    dem_voters - rep_voters
  end

  def absolute_registration_advantage
    registration_advantage*-1
  end

  def other_voters_calculation
    
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

  def self.my_import(file)
    districts = []
    CSV.foreach(file.path, headers: true) do |row|
      districts << District.new(row.to_h)
    end
    District.import districts, recursive: true 
  end

end
