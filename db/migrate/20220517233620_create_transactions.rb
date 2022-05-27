class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :candidate_committee, foreign_key: true
      t.references :import, foreign_key: true
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

      t.timestamps
    end
  end
end
