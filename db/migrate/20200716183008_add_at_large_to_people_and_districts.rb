class AddAtLargeToPeopleAndDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :running_at_large, :boolean, :default => false
    add_column :districts, :at_large_district, :boolean, :default => false
  end
end
