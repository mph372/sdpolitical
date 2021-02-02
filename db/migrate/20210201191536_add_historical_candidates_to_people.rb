class AddHistoricalCandidatesToPeople < ActiveRecord::Migration[5.2]
  def change
    add_reference :people, :historical_candidates, foreign_key: true
  end
end
