class AddAtLargeToJurisdictions < ActiveRecord::Migration[6.1]
  def change
    add_column :jurisdictions, :at_large_districts, :boolean
  end
end
