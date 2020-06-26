class CreateCommittees < ActiveRecord::Migration[5.2]
  def change
    create_table :committees do |t|
      t.string :name
      t.references :jurisdiction, foreign_key: true
      t.string :type
      t.references :measure, foreign_key: true
      t.boolean :support
      t.boolean :is_active

      t.timestamps
    end
  end
end
