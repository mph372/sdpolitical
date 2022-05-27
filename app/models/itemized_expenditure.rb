class ItemizedExpenditure < ApplicationRecord
  belongs_to :expenditure, optional: true
  belongs_to :campaign, optional: true
  delegate :candidate, to: :expenditure
  delegate :committee, to: :expenditure


def set_campaign
  campaign = expenditure.candidate.campaign.id
  update_attribute(:campaign_id, campaign)
end

end


