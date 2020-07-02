class ChangeDefaultValuesForPeople < ActiveRecord::Migration[5.2]
  def change
    change_column_default :people, :is_incumbent, false
    change_column_default :users, :admin, false
  end
end
