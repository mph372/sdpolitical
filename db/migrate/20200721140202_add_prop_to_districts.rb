class AddPropToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :prop_6_yes, :integer
    add_column :districts, :prop_6_no, :integer
    add_column :districts, :prop_51_yes, :integer
    add_column :districts, :prop_51_no, :integer
    add_column :districts, :prop_62_yes, :integer
    add_column :districts, :prop_62_no, :integer
  end
end

