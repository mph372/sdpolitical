class AddGoogleMapsUrlToJurisdictions < ActiveRecord::Migration[6.1]
  def change
    add_column :jurisdictions, :google_maps_url, :string
  end
end
