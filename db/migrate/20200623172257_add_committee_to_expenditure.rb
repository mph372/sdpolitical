class AddCommitteeToExpenditure < ActiveRecord::Migration[5.2]
  def change
    add_reference :expenditures, :committee, foreign_key: true
  end
end
