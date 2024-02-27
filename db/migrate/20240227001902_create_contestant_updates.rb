class CreateContestantUpdates < ActiveRecord::Migration[6.1]
  def change
    create_table :contestant_updates do |t|
      t.integer :mail_ballots_votes
      t.integer :vote_center_ballots_votes
      t.integer :provisional_votes
      t.integer :total_votes
      t.integer :number_of_precincts
      t.integer :precincts_reported
      t.integer :ballots_cast
      t.references :contestant, foreign_key: true

      t.timestamps
    end
  end
end
