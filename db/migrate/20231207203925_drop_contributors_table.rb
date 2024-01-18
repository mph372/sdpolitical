class DropContributorsTable < ActiveRecord::Migration[6.1]
  def up
    # Remove foreign key constraint from the transactions table
    if foreign_key_exists?(:transactions, :contributors)
      remove_foreign_key :transactions, :contributors
    end

    # Now, safely drop the contributors table
    drop_table :contributors
  end

  def down
    create_table :contributors do |t|
      t.bigint :transaction_id
      t.string :first_name
      t.string :last_name
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :full_name
      t.bigint :committee_id
      t.index ["committee_id"], name: "index_contributors_on_committee_id"
      t.index ["transaction_id"], name: "index_contributors_on_transaction_id"
    end

    # Recreate the foreign key constraint in the transactions table
    add_foreign_key :transactions, :contributors
  end
end
