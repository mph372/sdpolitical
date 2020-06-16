class District < ApplicationRecord
  belongs_to :jurisdiction 
  has_many :candidates, inverse_of: :district, class_name: 'Person'
  belongs_to :incumbent, inverse_of: :incumbent_district, class_name: 'Person', foreign_key: 'incumbent_id'
  has_many :reports, through: :persons
  def registration_advantage
    dem_percent - rep_percent
  end
end
