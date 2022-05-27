class AddCandidateToExpenditure < ActiveRecord::Migration[5.2]
  def change
    add_reference :expenditures, :candidate, foreign_key: true
  end
end
