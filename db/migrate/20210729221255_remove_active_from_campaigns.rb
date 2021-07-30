class RemoveActiveFromCampaigns < ActiveRecord::Migration[5.2]
  def change
    remove_column :campaigns, :active, :boolean
  end
end
