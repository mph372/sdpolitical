class ChangeDefaultValueInCommittees < ActiveRecord::Migration[5.2]
  def change
    change_column_default :committees, :is_active, true
  end
end
