class AddDistrictMapToDistricts < ActiveRecord::Migration[6.1]
  def change
    add_column :districts, :district_map, :string
  end
end
