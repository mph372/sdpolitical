class AddStatsToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :registered_2018, :integer
    add_column :districts, :voted_2018, :integer
    add_column :districts, :registered_2016, :integer
    add_column :districts, :voted_2016, :integer
    add_column :districts, :registered_2014, :integer
    add_column :districts, :voted_2014, :integer
    add_column :districts, :registered_2012, :integer
    add_column :districts, :voted_2012, :integer
  end
end

