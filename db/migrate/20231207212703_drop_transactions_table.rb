class DropTransactionsTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :transactions
  end

  def down
    create_table :transactions, force: :cascade do |t|
      t.bigint :candidate_committee_id
      t.bigint :import_id
      t.string :transaction_type
      t.string :entity_type
      t.string :entity_last_name
      t.string :entity_first_name
      t.string :entity_addr1
      t.string :entity_addr2
      t.string :entity_city
      t.string :entity_state
      t.string :entity_zip
      t.string :entity_employer
      t.string :entity_occupation
      t.date :transaction_date
      t.float :amount
      t.string :expense_code
      t.string :description
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.bigint :contributor_id
      t.bigint :vendor_id
      t.string :full_name
      t.string :unique_key
      t.string :payment_type
      t.string :organization_name
      t.string :fec_receipt_type
      t.bigint :candidate_id
      t.bigint :committee_id
      t.string :support_oppose_code
      t.string :candidate_last_name
      t.string :candidate_first_name
      t.string :candidate_full_name
      t.bigint :report_id
      t.index ["candidate_committee_id"], name: "index_transactions_on_candidate_committee_id"
      t.index ["candidate_id"], name: "index_transactions_on_candidate_id"
      t.index ["committee_id"], name: "index_transactions_on_committee_id"
      t.index ["contributor_id"], name: "index_transactions_on_contributor_id"
      t.index ["import_id"], name: "index_transactions_on_import_id"
      t.index ["report_id"], name: "index_transactions_on_report_id"
      t.index ["vendor_id"], name: "index_transactions_on_vendor_id"
    end
  end
end
