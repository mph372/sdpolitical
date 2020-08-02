class Report < ApplicationRecord
  belongs_to :committee, optional: true
  delegate :district, to: :person
  delegate :incumbent_district, to: :person
  belongs_to :person, optional: true

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

  def current_period
    if period_begin == most_recent_filing_period_start
      return true
    end
  end




end
