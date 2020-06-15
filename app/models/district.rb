class District < ApplicationRecord
  belongs_to :jurisdiction 
  has_many :persons
  has_many :reports, through: :persons
  def registration_advantage
    dem_percent - rep_percent
  end
end
