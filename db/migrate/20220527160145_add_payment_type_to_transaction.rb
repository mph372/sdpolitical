class AddPaymentTypeToTransaction < ActiveRecord::Migration[5.2]
  def change
    add_column :transactions, :payment_type, :string
  end
end
