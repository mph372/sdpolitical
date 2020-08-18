class CreateRegistrationHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :registration_histories do |t|
      t.integer :total_2010
      t.integer :total_2012
      t.integer :total_2014
      t.integer :total_2016
      t.integer :total_2018
      t.integer :total_2020
      t.integer :gop_2010
      t.integer :gop_2012
      t.integer :gop_2014
      t.integer :gop_2016
      t.integer :gop_2018
      t.integer :gop_2020
      t.integer :dem_2010
      t.integer :dem_2012
      t.integer :dem_2014
      t.integer :dem_2016
      t.integer :dem_2018
      t.integer :dem_2020
      t.references :district, foreign_key: true
      t.references :jurisdiction, foreign_key: true
      t.string :name
      t.timestamps
    end
  end
end
