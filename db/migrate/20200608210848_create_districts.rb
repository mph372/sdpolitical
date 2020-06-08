class CreateDistricts < ActiveRecord::Migration[5.2]
  def change
    create_table :districts do |t|
      t.string :name
      t.string :district
      t.integer :total_voters
      t.float :dem_percent
      t.float :rep_percent
      t.float :other_percent
      t.float :newsom_percent
      t.float :cox_percent
      t.float :clinton_percent
      t.float :trump_percent
      t.float :brown_percent
      t.float :kashkar_percent
      t.float :obama_percent
      t.float :romney_percent
      t.float :average_percent
      t.references :jurisdiction, foreign_key: true

      t.timestamps
    end
  end
end
