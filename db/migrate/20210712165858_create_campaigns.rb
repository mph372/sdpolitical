class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.references :district, foreign_key: true
      t.date :election_date
      t.string :election_type
      t.string :number_of_winners

      t.timestamps
    end
  end
end
