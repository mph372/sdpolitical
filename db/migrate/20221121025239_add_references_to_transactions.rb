class AddReferencesToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :report, foreign_key: true
  end
end
