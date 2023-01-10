class AddGovToStatisticalData < ActiveRecord::Migration[5.2]
  def change
    add_column :statistical_data, :newsom_2022, :float
    add_column :statistical_data, :dahle_2022, :float
  end
end
