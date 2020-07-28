class AddAreaToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :is_area, :boolean, :default => false
  end
end
