class AddTextToJurisdiction < ActiveRecord::Migration[5.2]
  def change
    add_column :jurisdictions, :description, :text
  end
end
