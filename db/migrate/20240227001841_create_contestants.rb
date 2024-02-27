class CreateContestants < ActiveRecord::Migration[6.1]
  def change
    create_table :contestants do |t|
      t.string :name
      t.string :party
      t.references :contest, foreign_key: true

      t.timestamps
    end
  end
end
