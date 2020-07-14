class AddOpposeToCommittees < ActiveRecord::Migration[5.2]
  def change
    add_column :committees, :is_oppose, :boolean, :default => false
  end
end
