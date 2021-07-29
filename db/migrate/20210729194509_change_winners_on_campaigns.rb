class ChangeWinnersOnCampaigns < ActiveRecord::Migration[5.2]
  def change
    change_column :campaigns, :number_of_winners, :integer, using: 'number_of_winners::integer'
  end
end
