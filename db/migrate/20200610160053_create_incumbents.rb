class CreateIncumbents < ActiveRecord::Migration[5.2]
  def change
    create_table :incumbents do |t|
      t.references :district, foreign_key: true
      t.string :title
      t.string :first_name
      t.string :last_name
      t.date :birth_date
      t.string :party
      t.integer :first_elected
      t.string :prior_elected
      t.integer :salary
      t.string :professional_career
      t.integer :congressional_district
      t.integer :assembly_district
      t.integer :senate_district
      t.integer :supe_district
      t.integer :birth_place
      t.string :email
      t.string :twitter
      t.string :facebook
      t.string :phone
      t.integer :term
      t.boolean :on_ballot
      t.timestamps
    end
  end
end
