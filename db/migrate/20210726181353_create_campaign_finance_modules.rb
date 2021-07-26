class CreateCampaignFinanceModules < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_finance_modules do |t|
      t.boolean :corporate
      t.boolean :pac
      t.boolean :party
      t.integer :contribution_limit
      t.integer :party_limit
      
      t.references :jurisdiction, foreign_key: true
      t.references :district, foreign_key: true
      t.timestamps
    end
  end
end
