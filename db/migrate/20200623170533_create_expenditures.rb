class CreateExpenditures < ActiveRecord::Migration[5.2]
  def change
    create_table :expenditures do |t|
      t.date :expenditure_date
      t.string :description
      t.float :amount
      t.references :person, foreign_key: true
      t.references :measure, foreign_key: true
      t.boolean :is_support
      t.boolean :is_amendment

      t.timestamps
    end
  end
end
