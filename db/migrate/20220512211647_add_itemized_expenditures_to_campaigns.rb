class AddItemizedExpendituresToCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_reference :campaigns, :itemized_expenditures, foreign_key: true
  end
end
