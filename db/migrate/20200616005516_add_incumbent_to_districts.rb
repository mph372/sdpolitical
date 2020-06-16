class AddIncumbentToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_column :districts, :incumbent_id, :integer
  end
end
