class AddElectionInfoToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :campaigns, :number_winners, :string
    add_column :campaigns, :election_type, :string
  end
end
