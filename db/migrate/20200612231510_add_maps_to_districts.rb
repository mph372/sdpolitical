class AddMapsToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :map_url, :string
  end
end
