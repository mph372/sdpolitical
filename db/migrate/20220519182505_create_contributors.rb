class CreateContributors < ActiveRecord::Migration[5.2]
  def change
    create_table :contributors do |t|
      t.references :transaction, foreign_key: true
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
