class District < ApplicationRecord
  belongs_to :jurisdiction
  has_many :incumbents
  has_many :candidates

  def registration_advantage
    dem_percent - rep_percent
  end
end
