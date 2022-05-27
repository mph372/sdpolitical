class AddContributorToTransactions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :contributor, foreign_key: true
  end
end
