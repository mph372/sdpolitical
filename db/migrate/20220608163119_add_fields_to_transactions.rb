class AddFieldsToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :support_oppose_code, :string
    add_column :transactions, :candidate_last_name, :string
    add_column :transactions, :candidate_first_name, :string
    add_column :transactions, :candidate_full_name, :string
  end
end
