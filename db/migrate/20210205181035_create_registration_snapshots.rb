class CreateRegistrationSnapshots < ActiveRecord::Migration[5.2]
  def change
    create_table :registration_snapshots do |t|
      t.date :snapshot_date
      t.integer :total_registered
      t.integer :registered_dem
      t.integer :registered_rep
      t.integer :registered_other
      t.references :statistical_data, foreign_key: true

      t.timestamps
    end
  end
end
