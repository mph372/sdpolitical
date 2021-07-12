class CreateCandidates < ActiveRecord::Migration[5.2]
  def change
    create_table :campaign_candidates do |t|
      t.references :campaign, foreign_key: true
      t.references :person, foreign_key: true
      t.string :ballot_status
      t.string :campaign_email
      t.string :campaign_phone
      t.string :campaign_twitter
      t.string :campaign_facebook
      t.string :campaign_website

      t.timestamps
    end
  end
end
