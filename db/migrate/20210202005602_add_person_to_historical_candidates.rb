class AddPersonToHistoricalCandidates < ActiveRecord::Migration[5.2]
  def change
    add_reference :historical_candidates, :person, foreign_key: true
  end
end
