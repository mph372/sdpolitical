class CreateTrackers < ActiveRecord::Migration[5.2]
  def change
    create_table :trackers do |t|
      t.integer :district_id
      t.integer :user_id

      t.timestamps
    end
  end
end
