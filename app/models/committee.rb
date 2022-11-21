class Committee < ApplicationRecord
  belongs_to :jurisdiction, optional: true
  belongs_to :person, optional: true
  belongs_to :measure, optional: true
  has_many :reports
  has_many :expenditures

  def aggregate_support
    "#{self.expenditures.where(:is_support => true).sum(:amount)}"
  end

  def aggregate_oppose
    "#{self.expenditures.where(:is_oppose => true).sum(:amount)}"
  end

  def aggregate_expenditures
    self.expenditures.sum(:amount)
  end
end
