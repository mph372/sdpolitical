class AddColumnsToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_reference :districts, :incumbent, foreign_key: true
  end
end
