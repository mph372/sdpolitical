class CreateMeasures < ActiveRecord::Migration[5.2]
  def change
    create_table :measures do |t|
      t.string :letter
      t.text :text
      t.string :topic
      t.string :type
      t.string :origin
      t.references :jurisdiction, foreign_key: true
      t.float :threshold

      t.timestamps
    end
  end
end
