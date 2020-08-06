class CreateUpdates < ActiveRecord::Migration[5.2]
  def change
    create_table :updates do |t|
      t.text :message

      t.timestamps
    end
  end
end
