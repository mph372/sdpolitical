class DropMultipleTables < ActiveRecord::Migration[6.1]
  def up
    drop_table :notifications
    drop_table :other_districts
    drop_table :otherdistricts
  end

  def down
    create_table :notifications do |t|
      t.integer :recipient_id
      t.datetime :read_at
      t.integer :notifiable_id
      t.string :notifiable_type
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end

    create_table :other_districts do |t|
      # Add columns if there were any originally
    end

    create_table :otherdistricts do |t|
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
