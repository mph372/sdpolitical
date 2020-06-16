class AddIncumbentIndexToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_index :districts, :incumbent_id
  end
end
