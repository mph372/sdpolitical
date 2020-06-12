class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :candidates do |t|
      t.references :district, foreign_key: true
      t.date :birth_date
      t.string :party
      t.string :professional_career
      t.string :email
      t.string :campaign_website
      t.string :twitter
      t.string :facebook

      t.timestamps
    end
  end
end
