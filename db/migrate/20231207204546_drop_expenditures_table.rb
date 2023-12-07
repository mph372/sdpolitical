class DropExpendituresTable < ActiveRecord::Migration[6.1]
  def up
    # Check if the foreign key exists and remove it
    if foreign_key_exists?(:itemized_expenditures, :expenditures)
      remove_foreign_key :itemized_expenditures, :expenditures
    end

    # Now, safely drop the expenditures table
    drop_table :expenditures
  end

  def down
    create_table :expenditures do |t|
      t.date :expenditure_date
      t.string :description
      t.float :amount
      t.bigint :person_id
      t.bigint :measure_id
      t.boolean :is_support, default: false
      t.boolean :is_amendment
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.bigint :committee_id
      t.bigint :district_id
      t.string :election_type
      t.integer :election_cycle
      t.boolean :is_oppose, default: false
      t.string :pdf
      t.bigint :candidate_id
      t.index ["candidate_id"], name: "index_expenditures_on_candidate_id"
      t.index ["committee_id"], name: "index_expenditures_on_committee_id"
      t.index ["district_id"], name: "index_expenditures_on_district_id"
      t.index ["measure_id"], name: "index_expenditures_on_measure_id"
      t.index ["person_id"], name: "index_expenditures_on_person_id"
    end

    # Recreate the foreign key in the itemized_expenditures table
    add_foreign_key :itemized_expenditures, :expenditures
  end
end
