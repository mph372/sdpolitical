class CreateJoinTableDistrictsPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people_districts, id: false do |t|
      t.references :district, index: true, foreign_key: true
      t.references :person, index: true, foreign_key: true
  

      t.timestamps null: false
    end
   end
end
