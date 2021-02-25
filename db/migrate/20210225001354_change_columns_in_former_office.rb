class ChangeColumnsInFormerOffice < ActiveRecord::Migration[5.2]
  def change
    remove_column :former_offices, :start_year
    remove_column :former_offices, :end_year

    add_column :former_offices, :start_year, :integer
    add_column :former_offices, :end_year, :integer
  end
end
