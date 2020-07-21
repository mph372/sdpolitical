class AddOpposeToExpenditures < ActiveRecord::Migration[5.2]
  def change
    add_column :expenditures, :is_oppose, :boolean, :default => false
    change_column_default :expenditures, :is_support, false
  end
end
