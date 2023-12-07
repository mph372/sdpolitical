class DropImportsTable < ActiveRecord::Migration[6.1]
  def up
    # Remove foreign key constraints referencing the imports table
    remove_foreign_key :reports, :imports if foreign_key_exists?(:reports, :imports)
    remove_foreign_key :transactions, :imports if foreign_key_exists?(:transactions, :imports)

    # Now, safely drop the imports table
    drop_table :imports
  end

  def down
    create_table :imports do |t|
      t.bigint :candidate_committee_id
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.bigint :committee_id
      t.bigint :jurisdiction_id
      t.index ["candidate_committee_id"], name: "index_imports_on_candidate_committee_id"
      t.index ["committee_id"], name: "index_imports_on_committee_id"
      t.index ["jurisdiction_id"], name: "index_imports_on_jurisdiction_id"
    end

    # Recreate the foreign key constraints in the reports and transactions tables
    add_foreign_key :reports, :imports
    add_foreign_key :transactions, :imports
  end
end
