class CreateFormerOffices < ActiveRecord::Migration[5.2]
  def change
    create_table :former_offices do |t|
      t.references :district, foreign_key: true
      t.boolean :elected
      t.boolean :appointed
      t.date :start_year
      t.date :end_year
      t.references :person, foreign_key: true

      t.timestamps
    end
  end
end
