class AddReferncesToDistrictsAndPeople < ActiveRecord::Migration[5.2]
  def change
    add_reference :districts, :person, foreign_key: true
  end
end
