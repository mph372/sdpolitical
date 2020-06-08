class AddColumnsToJurisdiction < ActiveRecord::Migration[5.2]
  def change
    add_column :jurisdictions, :corporate_contributions, :boolean
    add_column :jurisdictions, :pac_contributions, :boolean
    add_column :jurisdictions, :party_contributions, :boolean
  end
end
