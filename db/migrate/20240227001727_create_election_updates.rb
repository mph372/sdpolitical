class CreateElectionUpdates < ActiveRecord::Migration[6.1]
  def change
    create_table :election_updates do |t|
      t.integer :ballots_cast
      t.integer :mail_ballots
      t.integer :vote_center_ballots
      t.integer :registered_voters
      t.references :election, foreign_key: true

      t.timestamps
    end
  end
end
