class AddAtLargeToFormerOffices < ActiveRecord::Migration[5.2]
  def change
    add_column :former_offices, :at_large, :boolean, default: false
  end
end
