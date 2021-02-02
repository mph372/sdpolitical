class AddReferencesToHistoricalCandidates < ActiveRecord::Migration[5.2]
  def change
    add_reference :historical_candidates, :people, foreign_key: true
  end
end
