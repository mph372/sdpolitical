class AddJurisdictionTypeToJurisdictions < ActiveRecord::Migration[5.2]
  def change
    add_column :jurisdictions, :jurisdiction_type, :string
  end
end
