class DropMeasuresTable < ActiveRecord::Migration[6.1]
  def up

    if foreign_key_exists?(:committees, :measures)
      remove_foreign_key :committees, :measures
    end
    remove_foreign_key :expenditures, :measures
    
    drop_table :measures
  end

  def down
    create_table :measures do |t|
      t.string :letter
      t.text :text
      t.string :topic
      t.string :measure_type
      t.string :origin
      t.bigint :jurisdiction_id
      t.float :threshold
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string :pdf
      t.string :gop_support
      t.string :dem_support
      t.index ["jurisdiction_id"], name: "index_measures_on_jurisdiction_id"
    end
  end
end
