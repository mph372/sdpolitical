class ChangeNumberFormatInStatisticalData < ActiveRecord::Migration[5.2]
  def up
    change_column :statistical_data, :obama_2012, :float
    change_column :statistical_data, :romney_2012, :float
    change_column :statistical_data, :trump_2016, :float
    change_column :statistical_data, :clinton_2016, :float
    change_column :statistical_data, :trump_2020, :float
    change_column :statistical_data, :biden_2020, :float
    change_column :statistical_data, :newsom_2018, :float
    change_column :statistical_data, :cox_2018, :float
    change_column :statistical_data, :kashkari_2014, :float
    change_column :statistical_data, :brown_2014, :float
  end

  def down
    change_column :statistical_data, :obama_2012, :integer
    change_column :statistical_data, :romney_2012, :integer
    change_column :statistical_data, :trump_2016, :integer
    change_column :statistical_data, :clinton_2016, :integer
    change_column :statistical_data, :trump_2020, :integer
    change_column :statistical_data, :biden_2020, :integer
    change_column :statistical_data, :newsom_2018, :integer
    change_column :statistical_data, :cox_2018, :integer
    change_column :statistical_data, :kashkari_2014, :integer
    change_column :statistical_data, :brown_2014, :integer
  end
end
