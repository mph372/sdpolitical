class AddCampaignableToCampaigns < ActiveRecord::Migration[6.1]
  def change
    add_reference :campaigns, :campaignable, polymorphic: true, index: true
  end
end
