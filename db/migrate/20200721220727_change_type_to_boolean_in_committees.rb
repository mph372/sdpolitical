class ChangeTypeToBooleanInCommittees < ActiveRecord::Migration[5.2]
  def change
    remove_column :committees, :support
    add_column :committees, :is_support, :boolean, :default => false
  end
end
