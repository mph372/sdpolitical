class DropDistrictFormerOffices < ActiveRecord::Migration[5.2]
  def change
    drop_table :district_former_offices
  end
end
