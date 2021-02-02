class CreateHistoricalCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :historical_candidates do |t|
      t.references :election_history, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.integer :votes
      t.boolean :is_winner

      t.timestamps
    end
  end
end
