class Report < ApplicationRecord
  belongs_to :committee, optional: true
  delegate :district, to: :person
  belongs_to :person, optional: true

  def net_coh
    current_coh - current_debt
  end
end
