class AddFecReceiptTypeToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :fec_receipt_type, :string
  end
end
