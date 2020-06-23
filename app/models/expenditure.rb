class Expenditure < ApplicationRecord
  belongs_to :person, optional: true
  belongs_to :measure, optional: true
  belongs_to :committee
  belongs_to :district
  
  def strip_trailing_zero(n)
    n.to_s.sub(/\.?0+$/, '')
  end

end
