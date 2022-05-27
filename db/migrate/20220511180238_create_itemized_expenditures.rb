class CreateItemizedExpenditures < ActiveRecord::Migration[5.2]
  def change
    create_table :itemized_expenditures do |t|
      t.references :expenditure, foreign_key: true
      t.date :date
      t.string :description
      t.float :amount

      t.timestamps
    end
  end
end
