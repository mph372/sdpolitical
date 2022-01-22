class AddPopulationToStatisticalData < ActiveRecord::Migration[5.2]
  def change
    add_column :statistical_data, :total_population, :integer
  end
end
