class AddCandidatesToTransctions < ActiveRecord::Migration[5.2]
  def change
    add_reference :transactions, :candidate, foreign_key: true
  end
end
