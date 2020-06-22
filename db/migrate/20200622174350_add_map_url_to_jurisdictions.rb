class AddMapUrlToJurisdictions < ActiveRecord::Migration[5.2]
  def change
    add_column :jurisdictions, :map_url, :string
  end
end
