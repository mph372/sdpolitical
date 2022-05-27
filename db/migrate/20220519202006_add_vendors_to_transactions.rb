class AddVendorsToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :vendor, foreign_key: true
  end
end
