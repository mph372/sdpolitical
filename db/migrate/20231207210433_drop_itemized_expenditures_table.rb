class DropItemizedExpendituresTable < ActiveRecord::Migration[6.1]
  def up
    # Remove foreign key constraint from the campaigns table
    remove_foreign_key :campaigns, :itemized_expenditures if foreign_key_exists?(:campaigns, :itemized_expenditures)

    # Now, safely drop the itemized_expenditures table
    drop_table :itemized_expenditures
  end

  def down
    create_table :itemized_expenditures do |t|
      t.bigint :expenditure_id
      t.date :date
      t.string :description
      t.float :amount
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.bigint :campaign_id
      t.index ["campaign_id"], name: "index_itemized_expenditures_on_campaign_id"
      t.index ["expenditure_id"], name: "index_itemized_expenditures_on_expenditure_id"
    end

    # Recreate the foreign key in the campaigns table
    add_foreign_key :campaigns, :itemized_expenditures
  end
end
