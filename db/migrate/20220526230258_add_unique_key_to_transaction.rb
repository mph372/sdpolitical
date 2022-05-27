class AddUniqueKeyToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :unique_key, :string
  end
end
