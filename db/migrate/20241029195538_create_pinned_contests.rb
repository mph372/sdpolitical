class CreatePinnedContests < ActiveRecord::Migration[6.1]
  def change
    create_table :pinned_contests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :contest, null: false, foreign_key: true
      t.integer :pin_order, null: false, default: 0
      
      t.timestamps
      
      # Ensure a user can't pin the same contest multiple times
      t.index [:user_id, :contest_id], unique: true
    end
  end
end
