class Person < ApplicationRecord
  belongs_to :district
  has_many :reports do
    def most_recent
      order(report_filed: :desc).first
    end
  end
  mount_uploader :image, IncumbentUploader

  def calculated_age
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end


end
