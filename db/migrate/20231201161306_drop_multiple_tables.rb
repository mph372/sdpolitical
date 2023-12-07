class DropMultipleTables < ActiveRecord::Migration[6.1]
  def up
    drop_table :contributors, force: :cascade
    drop_table :dashboards
    drop_table :delayed_jobs
    drop_table :expenditures, force: :cascade
    drop_table :follows
    drop_table :imports, force: :cascade
    drop_table :itemized_expenditures, force: :cascade
    drop_table :measures
    drop_table :notifications
    drop_table :other_districts
    drop_table :otherdistricts
    drop_table :taggings
    drop_table :tags
    drop_table :transactions
    drop_table :updates
    drop_table :vendors
  end

  def down
    # Recreate tables with necessary columns if needed
    # For example:
    # create_table :contributors do |t|
    #   t.bigint :transaction_id
    #   t.string :first_name
    #   # Other fields...
    # end
    # Repeat for other tables...
  end
end
