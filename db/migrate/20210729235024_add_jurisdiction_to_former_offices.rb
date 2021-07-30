class AddJurisdictionToFormerOffices < ActiveRecord::Migration[5.2]
  def change
    add_reference :former_offices, :jurisdiction, foreign_key: true
    add_column :former_offices, :title, :string
  end
end
