class CreateElectionHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :election_histories do |t|
      t.integer :cycle
      t.string :election_type
      t.date :election_date
      t.integer :number_winners
      t.integer :total_votes
      t.references :district, foreign_key: true

      t.timestamps
    end
  end
end
