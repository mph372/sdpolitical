class AddCampaignWebsiteToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :campaign_email, :string
  end
end
