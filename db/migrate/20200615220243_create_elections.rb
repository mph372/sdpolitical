class CreateElections < ActiveRecord::Migration[5.2]
  def change
    create_table :elections do |t|
      t.integer :year
      t.references :district, foreign_key: true
      t.string :election_type

      t.timestamps
    end
  end
end
