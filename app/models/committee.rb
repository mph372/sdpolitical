class Committee < ApplicationRecord
  belongs_to :jurisdiction
  belongs_to :person, optional: true
  belongs_to :measure, optional: true
  has_many :reports
  has_many :expenditures
  has_many :transactions
  has_many :imports
  has_one :vendor
  has_one :contributor

  def aggregate_support
    "#{self.expenditures.where(:is_support => true).sum(:amount)}"
  end

  def aggregate_oppose
    "#{self.expenditures.where(:is_oppose => true).sum(:amount)}"
  end

  def aggregate_expenditures
    self.expenditures.sum(:amount)
  end

  
  def likely_independent_expenditures
    transactions.where.not(support_oppose_code: "").where.not(transaction_type: "RCPT").where.not(candidate_full_name: "").where(expense_code: "IND") 
  end

  def total_independent_expenditures
    likely_independent_expenditures.sum(:amount)
  end

  def committee_vendor_expenditures
    transactions.where(transaction_type: "EXPN").where(support_oppose_code: "").where(candidate_full_name: "").where.not(expense_code: "IND")
  end

  def committee_contributions
    transactions.where(expense_code: "CTB").or(transactions.where(expense_code: "CONTRIBUTION")).or(transactions.where(expense_code: "MON"))

  end

  def match_vendor_contributor
    Contributor.all.each do |c|
      if c.full_name.downcase.similar(name.downcase) > 90
        c.update_attributes(committee_id: id)
      end
    end
    Vendor.all.each do |v|
      if v.full_name.downcase.similar(name.downcase) > 90
        v.update_attributes(committee_id: id)
      end
    end
  end
  

end
