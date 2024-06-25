class AddGoogleMapsUrlToDistricts < ActiveRecord::Migration[6.1]
  def change
    add_column :districts, :google_maps_url, :string
  end
end
