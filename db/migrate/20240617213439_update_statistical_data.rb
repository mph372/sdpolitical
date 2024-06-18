class UpdateStatisticalData < ActiveRecord::Migration[6.1]
  def change
    remove_column :statistical_data, :prop_51_yes, :integer
    remove_column :statistical_data, :prop_51_no, :integer
    remove_column :statistical_data, :prop_62_yes, :integer
    remove_column :statistical_data, :prop_62_no, :integer

    add_column :statistical_data, :prop_1_yes, :integer
    add_column :statistical_data, :prop_1_no, :integer
  end
end
