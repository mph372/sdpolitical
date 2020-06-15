class District < ApplicationRecord
  belongs_to :jurisdiction
  has_many :incumbents
  has_many :candidates
  has_many :reports, through: :candidates 
  has_many :persons

  def registration_advantage
    dem_percent - rep_percent
  end
end
