class AddTermExpiresToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :term_expires, :integer
    add_column :districts, :measure_a_yes, :integer
    add_column :districts, :measure_a_no, :integer
  end
end
