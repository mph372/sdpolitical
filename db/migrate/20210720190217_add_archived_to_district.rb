class AddArchivedToDistrict < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :archived, :boolean, default: false
    add_column :people, :archived, :boolean, default: false
  end
end
