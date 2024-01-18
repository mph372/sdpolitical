class DropCommitteesTable < ActiveRecord::Migration[6.1]
  def up
    # Remove foreign key constraints from tables you plan to keep
    remove_foreign_key :reports, :committees

    # For tables you plan to drop eventually, you can use DROP CASCADE when dropping those tables.
    # However, since we are only dropping 'committees' here, we manually remove foreign keys from these tables.
    if foreign_key_exists?(:vendors, :committees)
      remove_foreign_key :vendors, :committees
    end
    remove_foreign_key :imports, :committees
    remove_foreign_key :transactions, :committees
    if foreign_key_exists?(:expenditures, :committees)
      remove_foreign_key :expenditures, :committees
    end    
    if foreign_key_exists?(:contributors, :committees)
      remove_foreign_key :contributors, :committees
    end
    if foreign_key_exists?(:candidates, :committees)
      remove_foreign_key :candidates, :committees
    end

    # Now, safely drop the committees table
    drop_table :committees
  end

  def down
    create_table :committees do |t|
      t.string :name
      t.bigint :jurisdiction_id
      t.string :committee_type
      t.bigint :measure_id
      t.boolean :is_active, default: true
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.bigint :person_id
      t.boolean :is_oppose, default: false
      t.boolean :is_support, default: false
      t.integer :filer_id
      t.index ["jurisdiction_id"], name: "index_committees_on_jurisdiction_id"
      t.index ["measure_id"], name: "index_committees_on_measure_id"
      t.index ["person_id"], name: "index_committees_on_person_id"
    end

    # Recreate the foreign key constraints
    add_foreign_key :reports, :committees
    # Add foreign keys for other tables if necessary when rolling back
  end
end
