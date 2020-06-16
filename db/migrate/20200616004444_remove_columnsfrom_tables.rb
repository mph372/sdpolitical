class RemoveColumnsfromTables < ActiveRecord::Migration[5.2]
  def change
    remove_column :committees, :incumbent_id
    remove_column :districts, :incumbent_id
  end
end
