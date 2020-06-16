class RemoveIndexes < ActiveRecord::Migration[5.2]
  def change
    remove_index :committees, :incumbent_id
    remove_index :districts, :incumbent_id
  end
end
