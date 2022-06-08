class AddCommitteesToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :committee, foreign_key: true
  end
end
