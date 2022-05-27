class Expenditure < ApplicationRecord
  # belongs_to :person, optional: true
  belongs_to :candidate, optional: true
  belongs_to :measure, optional: true
  belongs_to :committee
  has_many :itemized_expenditures, dependent: :destroy 
  mount_uploader :pdf, ExpenditureUploader
  cattr_accessor :current_user
  accepts_nested_attributes_for :itemized_expenditures, allow_destroy: true, reject_if: :all_blank

  def strip_trailing_zero(n)
    n.to_s.sub(/\.?0+$/, '')
  end

  def support_or_oppose
    if self.is_support == true
      "Support"
    elsif self.is_oppose == true
      "Oppose"
    end
  end

  def district_followers
    district_followers = []
    if self.person.present?
      if self.person.district.at_large_district == false
        self.person.district.followers.each do |follower|
        district_followers << follower
        end
      elsif self.person.district.at_large_district == true
        self.person.district.jurisdiction.districts.each do |district|
          district.followers.each do |follower|
          district_followers << follower
          end
        end
      end
    end
    return district_followers
  end

end
