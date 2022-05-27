class AddCampaignsToItemizedExpenditures < ActiveRecord::Migration[5.2]
  def change
    add_reference :itemized_expenditures, :campaign, foreign_key: true
  end
end
