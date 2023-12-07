class DropRegistrationHistoriesTable < ActiveRecord::Migration[6.1]
  def up
    # Remove foreign key constraints referencing the registration_histories table
    remove_foreign_key :districts, :registration_histories if foreign_key_exists?(:districts, :registration_histories)
    remove_foreign_key :jurisdictions, :registration_histories if foreign_key_exists?(:jurisdictions, :registration_histories)

    # Now, safely drop the registration_histories table
    drop_table :registration_histories
  end

  def down
    create_table :registration_histories do |t|
      t.integer :total_2012
      t.integer :total_2014
      t.integer :total_2016
      t.integer :total_2018
      t.integer :total_2020
      t.integer :gop_2012
      t.integer :gop_2014
      t.integer :gop_2016
      t.integer :gop_2018
      t.integer :gop_2020
      t.integer :dem_2012
      t.integer :dem_2014
      t.integer :dem_2016
      t.integer :dem_2018
      t.integer :dem_2020
      t.bigint :district_id
      t.bigint :jurisdiction_id
      t.string :name
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index ["district_id"], name: "index_registration_histories_on_district_id"
      t.index ["jurisdiction_id"], name: "index_registration_histories_on_jurisdiction_id"
    end
  end
end
