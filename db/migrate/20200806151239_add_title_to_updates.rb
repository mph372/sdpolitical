class AddTitleToUpdates < ActiveRecord::Migration[5.2]
  def change
    add_column :updates, :title, :string
  end
end
