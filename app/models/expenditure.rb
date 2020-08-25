class Expenditure < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :measure, optional: true
  belongs_to :committee
  mount_uploader :pdf, ExpenditureUploader
  cattr_accessor :current_user

  def strip_trailing_zero(n)
    n.to_s.sub(/\.?0+$/, '')
  end

  def support_or_oppose
    if self.is_support = true
      "Support"
    elsif self.is_oppose = true
      "Oppose"
    end
  end

  def tracked_expenditure
    @atlarge_candidates = current_user.following_by_type('District').includes(:candidates).select{|c| c.at_large_district == true}.collect{|u| u.jurisdiction.candidates}.flatten
    @district_candidates = current_user.following_by_type('District').includes(:candidates).collect{|u| u.candidates}.flatten
    @candidates = @district_candidates + @atlarge_candidates
    @expenditures = @candidates.collect{|u| u.expenditures}.flatten

    if @expenditures.include?(self)
      true
    end
  end

end
