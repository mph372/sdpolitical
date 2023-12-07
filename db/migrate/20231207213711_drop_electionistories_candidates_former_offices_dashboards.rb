class DropElectionistoriesCandidatesFormerOfficesDashboards < ActiveRecord::Migration[6.1]
  def up

    remove_foreign_key :historical_candidates, :election_histories if foreign_key_exists?(:historical_candidates, :election_histories)
    remove_foreign_key :people, :historical_candidates if foreign_key_exists?(:people, :historical_candidates)

    drop_table :campaign_finance_modules
    drop_table :election_histories
    drop_table :historical_candidates
    drop_table :districts_former_offices
    drop_table :dashboards
  end

  def down
    # Recreate campaign_finance_modules table
    create_table :campaign_finance_modules do |t|
      t.boolean :corporate
      t.boolean :pac
      t.boolean :party
      t.integer :contribution_limit
      t.integer :party_limit
      t.bigint :jurisdiction_id
      t.bigint :district_id
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index ["district_id"], name: "index_campaign_finance_modules_on_district_id"
      t.index ["jurisdiction_id"], name: "index_campaign_finance_modules_on_jurisdiction_id"
    end

    # Recreate election_histories table
    create_table :election_histories do |t|
      t.integer :cycle
      t.string :election_type
      t.date :election_date
      t.integer :number_winners
      t.integer :total_votes
      t.bigint :district_id
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.index ["district_id"], name: "index_election_histories_on_district_id"
    end

    # Recreate historical_candidates table
    create_table :historical_candidates do |t|
      t.bigint :election_history_id
      t.string :first_name
      t.string :last_name
      t.integer :votes
      t.boolean :is_winner
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.bigint :people_id
      t.bigint :person_id
      t.index ["election_history_id"], name: "index_historical_candidates_on_election_history_id"
      t.index ["people_id"], name: "index_historical_candidates_on_people_id"
      t.index ["person_id"], name: "index_historical_candidates_on_person_id"
    end

    add_foreign_key :historical_candidates, :election_histories


    # Recreate districts_former_offices table
    create_table :districts_former_offices, id: false do |t|
      t.bigint :district_id
      t.bigint :former_office_id
      t.index ["district_id"], name: "index_districts_former_offices_on_district_id"
      t.index ["former_office_id"], name: "index_districts_former_offices_on_former_office_id"
    end

    # Recreate dashboards table
    create_table :dashboards do |t|
      t.integer :district_id
      t.integer :user_id
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
