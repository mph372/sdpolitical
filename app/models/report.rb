class Report < ApplicationRecord
  belongs_to :candidate_committee, optional: true
  delegate :district, to: :person
  delegate :jurisdiction, to: :person
  delegate :incumbent_district, to: :person
  belongs_to :person, optional: true
  cattr_accessor :current_user


  mount_uploader :pdf, ReportUploader

  def net_coh
    current_coh - current_debt
  end

  def top_fundraiser
    Report.order('period_receipts').limit(3)
  end

  def most_recent_filing_period_start
    most_recent = Date.new(2020,1,19)
  end

  def burn_rate
    period_disbursements / period_receipts
  end

  def total_expenditures
    transactions.where(transaction_type: "EXPN").sum(:amount)
end

  def current_period
    if period_begin == most_recent_filing_period_start
      return true
    end
  end

  def report_name
    if self.person.present?
    "#{self.period_begin} - #{self.period_end} Report for #{self.person.full_name}"
    elsif self.committee.present?
      "#{self.period_begin} - #{self.period_end} Report for #{self.committee.name}"
    end
  end

  scope :with_election, -> { where("candidate.candidate_committee.reports > 0") }

  def gop_reports
    republicans = Person.all.where(party: "Republican")     
    gop_reports = []    
    republicans.each do |republican|       
      if republican.reports.present?         
        gop_reports << republican.reports.each.period_receipts 
      end 
    end
  end

=begin   
  def district_followers
    district_followers = []
    if self.district.at_large_district == false
      self.district.followers.each do |follower|
      district_followers << follower
      end
    elsif self.district.at_large_district == true
      self.district.jurisdiction.districts.each do |district|
        district.followers.each do |follower|
        district_followers << follower
        end
      end
    end
    return district_followers
  end
=end

  before_save :prevent_candidate_report

  private

  def prevent_candidate_report
    if self.committee.present?
      self.candidate_report = false
      self.incumbent_report = false
    end
  end

  



end
