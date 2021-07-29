class AddDataToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :total_votes, :integer
  end
end
