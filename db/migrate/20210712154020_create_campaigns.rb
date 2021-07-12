class CreateCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :campaigns do |t|
      t.references :district, foreign_key: true
      t.date :election_date

      t.timestamps
    end
  end
end
