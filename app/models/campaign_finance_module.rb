class CampaignFinanceModule < ApplicationRecord
  belongs_to :jurisdiction, optional: true
  belongs_to :district, optional: true
end
