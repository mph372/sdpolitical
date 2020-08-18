class AddReferencesToDistricts < ActiveRecord::Migration[5.2]
  def change
    add_reference :districts, :registration_history, foreign_key: true
  end
end
