class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.references :district, foreign_key: true
      t.string :title
      t.string :first_name
      t.string :last_name
      t.date :birthdate
      t.string :party
      t.date :first_elected
      t.string :prior_elected
      t.integer :salary
      t.string :professional_career
      t.integer :congressional_district
      t.integer :assembly_district
      t.integer :senate_district
      t.integer :supe_district
      t.string :birthplace
      t.string :email
      t.string :twitter
      t.string :facebook
      t.string :phone
      t.integer :term
      t.boolean :on_ballot
      t.string :image
      t.integer :term_expires
      t.integer :seeking_office
      t.string :official_website
      t.string :campaign_website
      t.boolean :is_incumbent

      t.timestamps
    end
  end
end
