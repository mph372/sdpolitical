class CreateStatisticalData < ActiveRecord::Migration[5.2]
  def change
    create_table :statistical_data do |t|
      t.references :district, foreign_key: true
      t.references :jurisdiction, foreign_key: true
      t.integer :district_year
      t.integer :measure_a_yes
      t.integer :measure_a_no
      t.integer :number_of_winners
      t.integer :registered_2018
      t.integer :voted_2018
      t.integer :registered_2016
      t.integer :voted_2016
      t.integer :registered_2014
      t.integer :voted_2014
      t.integer :registered_2012
      t.integer :voted_2012
      t.integer :registered_2020
      t.integer :voted_2020
      t.integer :prop_6_yes
      t.integer :prop_6_no
      t.integer :prop_51_yes
      t.integer :prop_51_no
      t.integer :prop_62_yes
      t.integer :prop_62_no
      t.integer :prop_15_yes
      t.integer :prop_15_no
      t.integer :prop_16_yes
      t.integer :prop_16_no
      t.integer :prop_21_yes
      t.integer :prop_21_no
      t.integer :obama_2012
      t.integer :romney_2012
      t.integer :trump_2016
      t.integer :clinton_2016
      t.integer :trump_2020
      t.integer :biden_2020
      t.integer :newsom_2018
      t.integer :cox_2018
      t.integer :brown_2014
      t.integer :kashkari_2014
      t.timestamps
    end
  end
end
