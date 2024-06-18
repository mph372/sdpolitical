class RemoveIncumbentIdFromDistricts < ActiveRecord::Migration[6.1]
  def change
    remove_column :districts, :incumbent_id, :integer
  end
end
