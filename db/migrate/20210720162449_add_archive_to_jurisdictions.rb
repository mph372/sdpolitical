class AddArchiveToJurisdictions < ActiveRecord::Migration[5.2]
  def change
    add_column :jurisdictions, :archived, :boolean, default: false
  end
end
