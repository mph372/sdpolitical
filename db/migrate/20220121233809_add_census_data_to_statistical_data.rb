class AddCensusDataToStatisticalData < ActiveRecord::Migration[5.2]
  def change
    add_column :statistical_data, :white, :float
    add_column :statistical_data, :hispanic, :float
    add_column :statistical_data, :black, :float
    add_column :statistical_data, :asian, :float
    add_column :statistical_data, :native, :float
    add_column :statistical_data, :pacific, :float
  end
end
