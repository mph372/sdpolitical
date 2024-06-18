class AddRegisteredAndVoted2022ToStatisticalData < ActiveRecord::Migration[6.1]
  def change
    add_column :statistical_data, :registered_2022, :integer
    add_column :statistical_data, :voted_2022, :integer
  end
end
