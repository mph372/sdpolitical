class CreateContests < ActiveRecord::Migration[6.1]
  def change
    create_table :contests do |t|
      t.string :name
      t.references :election, foreign_key: true

      t.timestamps
    end
  end
end
