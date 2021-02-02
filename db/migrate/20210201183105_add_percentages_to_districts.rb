class AddPercentagesToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :biden_percent, :float
    add_column :districts, :trump20_percent, :float
    
  end
end
