class AddLogoToJurisdictions < ActiveRecord::Migration[5.2]
  def change
    add_column :jurisdictions, :logo, :string
  end
end
