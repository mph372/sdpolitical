class AddFullNameToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :full_name, :string
  end
end
