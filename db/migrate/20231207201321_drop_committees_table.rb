class DropCommitteesTable < ActiveRecord::Migration[6.1]
  def up
    # Only try to remove foreign keys if the committees table exists
    if table_exists?(:committees)
      # Remove foreign keys if they exist
      if foreign_key_exists?(:reports, :committees)
        remove_foreign_key :reports, :committees
      end

      # Check each foreign key before trying to remove it
      if foreign_key_exists?(:vendors, :committees)
        remove_foreign_key :vendors, :committees
      end

      if foreign_key_exists?(:imports, :committees)
        remove_foreign_key :imports, :committees
      end

      if foreign_key_exists?(:transactions, :committees)
        remove_foreign_key :transactions, :committees
      end

      if foreign_key_exists?(:expenditures, :committees)
        remove_foreign_key :expenditures, :committees
      end

      if foreign_key_exists?(:contributors, :committees)
        remove_foreign_key :contributors, :committees
      end

      if foreign_key_exists?(:candidates, :committees)
        remove_foreign_key :candidates, :committees
      end

      # Finally drop the table
      drop_table :committees
    end
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