# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_25_224650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.bigint "district_id"
    t.date "birth_date"
    t.string "party"
    t.string "professional_career"
    t.string "email"
    t.string "campaign_website"
    t.string "twitter"
    t.string "facebook"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["district_id"], name: "index_candidates_on_district_id"
  end

  create_table "committees", force: :cascade do |t|
    t.string "name"
    t.bigint "jurisdiction_id"
    t.string "committee_type"
    t.bigint "candidate_id"
    t.bigint "measure_id"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "person_id"
    t.boolean "is_oppose", default: false
    t.boolean "is_support", default: false
    t.index ["candidate_id"], name: "index_committees_on_candidate_id"
    t.index ["jurisdiction_id"], name: "index_committees_on_jurisdiction_id"
    t.index ["measure_id"], name: "index_committees_on_measure_id"
    t.index ["person_id"], name: "index_committees_on_person_id"
  end

  create_table "dashboards", force: :cascade do |t|
    t.integer "district_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deadlines", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.date "deadline_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.string "district"
    t.integer "total_voters"
    t.float "dem_percent"
    t.float "rep_percent"
    t.float "other_percent"
    t.float "newsom_percent"
    t.float "cox_percent"
    t.float "clinton_percent"
    t.float "trump_percent"
    t.float "brown_percent"
    t.float "kashkari_percent"
    t.float "obama_percent"
    t.float "romney_percent"
    t.float "average_percent"
    t.integer "jurisdiction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "map_url"
    t.integer "incumbent_id"
    t.integer "contribution_limit"
    t.boolean "corporate_contributions"
    t.boolean "pac_contributions"
    t.boolean "party_contributions"
    t.integer "party_contribution_limit"
    t.boolean "at_large_district", default: false
    t.integer "term_expires"
    t.integer "measure_a_yes"
    t.integer "measure_a_no"
    t.integer "number_of_winners"
    t.integer "registered_2018"
    t.integer "voted_2018"
    t.integer "registered_2016"
    t.integer "voted_2016"
    t.integer "registered_2014"
    t.integer "voted_2014"
    t.integer "registered_2012"
    t.integer "voted_2012"
    t.integer "registered_2020"
    t.integer "voted_2020"
    t.integer "prop_6_yes"
    t.integer "prop_6_no"
    t.integer "prop_51_yes"
    t.integer "prop_51_no"
    t.integer "prop_62_yes"
    t.integer "prop_62_no"
    t.boolean "is_seat", default: false
    t.boolean "is_area", default: false
    t.bigint "registration_history_id"
    t.float "biden_percent"
    t.float "trump20_percent"
    t.bigint "former_office_id"
    t.index ["former_office_id"], name: "index_districts_on_former_office_id"
    t.index ["incumbent_id"], name: "index_districts_on_incumbent_id"
    t.index ["jurisdiction_id"], name: "index_districts_on_jurisdiction_id"
    t.index ["registration_history_id"], name: "index_districts_on_registration_history_id"
  end

  create_table "districts_former_offices", id: false, force: :cascade do |t|
    t.bigint "district_id"
    t.bigint "former_office_id"
    t.index ["district_id"], name: "index_districts_former_offices_on_district_id"
    t.index ["former_office_id"], name: "index_districts_former_offices_on_former_office_id"
  end

  create_table "election_histories", force: :cascade do |t|
    t.integer "cycle"
    t.string "election_type"
    t.date "election_date"
    t.integer "number_winners"
    t.integer "total_votes"
    t.bigint "district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_election_histories_on_district_id"
  end

  create_table "elections", force: :cascade do |t|
    t.integer "year"
    t.bigint "district_id"
    t.string "election_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_elections_on_district_id"
  end

  create_table "expenditures", force: :cascade do |t|
    t.date "expenditure_date"
    t.string "description"
    t.float "amount"
    t.bigint "person_id"
    t.bigint "measure_id"
    t.boolean "is_support", default: false
    t.boolean "is_amendment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "committee_id"
    t.bigint "district_id"
    t.string "election_type"
    t.integer "election_cycle"
    t.boolean "is_oppose", default: false
    t.string "pdf"
    t.index ["committee_id"], name: "index_expenditures_on_committee_id"
    t.index ["district_id"], name: "index_expenditures_on_district_id"
    t.index ["measure_id"], name: "index_expenditures_on_measure_id"
    t.index ["person_id"], name: "index_expenditures_on_person_id"
  end

  create_table "follows", force: :cascade do |t|
    t.string "followable_type", null: false
    t.bigint "followable_id", null: false
    t.string "follower_type", null: false
    t.bigint "follower_id", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["followable_type", "followable_id"], name: "index_follows_on_followable_type_and_followable_id"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
    t.index ["follower_type", "follower_id"], name: "index_follows_on_follower_type_and_follower_id"
  end

  create_table "former_offices", force: :cascade do |t|
    t.bigint "district_id"
    t.boolean "elected"
    t.boolean "appointed"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "start_year"
    t.integer "end_year"
    t.index ["district_id"], name: "index_former_offices_on_district_id"
    t.index ["person_id"], name: "index_former_offices_on_person_id"
  end

  create_table "historical_candidates", force: :cascade do |t|
    t.bigint "election_history_id"
    t.string "first_name"
    t.string "last_name"
    t.integer "votes"
    t.boolean "is_winner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "people_id"
    t.bigint "person_id"
    t.index ["election_history_id"], name: "index_historical_candidates_on_election_history_id"
    t.index ["people_id"], name: "index_historical_candidates_on_people_id"
    t.index ["person_id"], name: "index_historical_candidates_on_person_id"
  end

  create_table "jurisdictions", force: :cascade do |t|
    t.string "name"
    t.integer "contribution_limit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "corporate_contributions"
    t.boolean "pac_contributions"
    t.boolean "party_contributions"
    t.text "description"
    t.string "map_url"
    t.string "jurisdiction_type"
    t.bigint "registration_history_id"
    t.index ["registration_history_id"], name: "index_jurisdictions_on_registration_history_id"
  end

  create_table "measures", force: :cascade do |t|
    t.string "letter"
    t.text "text"
    t.string "topic"
    t.string "measure_type"
    t.string "origin"
    t.bigint "jurisdiction_id"
    t.float "threshold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "pdf"
    t.string "gop_support"
    t.string "dem_support"
    t.index ["jurisdiction_id"], name: "index_measures_on_jurisdiction_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "recipient_id"
    t.datetime "read_at"
    t.integer "notifiable_id"
    t.string "notifiable_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "other_districts", force: :cascade do |t|
  end

  create_table "otherdistricts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.bigint "district_id"
    t.string "title"
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.string "party"
    t.date "first_elected"
    t.string "prior_elected"
    t.integer "salary"
    t.string "professional_career"
    t.integer "congressional_district"
    t.integer "assembly_district"
    t.integer "senate_district"
    t.integer "supe_district"
    t.string "birthplace"
    t.string "email"
    t.string "twitter"
    t.string "facebook"
    t.string "phone"
    t.integer "term"
    t.boolean "on_ballot", default: false
    t.string "image"
    t.integer "term_expires"
    t.integer "seeking_office"
    t.string "official_website"
    t.string "campaign_website"
    t.boolean "is_incumbent", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "running_reelection", default: false
    t.boolean "endorsed_republican"
    t.boolean "endorsed_democrat"
    t.string "ballot_status"
    t.text "bio"
    t.boolean "is_appointed"
    t.boolean "running_at_large", default: false
    t.integer "birth_day"
    t.integer "birth_month"
    t.string "incumbent_committee_name"
    t.string "linkedin_url"
    t.bigint "historical_candidates_id"
    t.index ["district_id"], name: "index_people_on_district_id"
    t.index ["historical_candidates_id"], name: "index_people_on_historical_candidates_id"
  end

  create_table "registration_histories", force: :cascade do |t|
    t.integer "total_2012"
    t.integer "total_2014"
    t.integer "total_2016"
    t.integer "total_2018"
    t.integer "total_2020"
    t.integer "gop_2012"
    t.integer "gop_2014"
    t.integer "gop_2016"
    t.integer "gop_2018"
    t.integer "gop_2020"
    t.integer "dem_2012"
    t.integer "dem_2014"
    t.integer "dem_2016"
    t.integer "dem_2018"
    t.integer "dem_2020"
    t.bigint "district_id"
    t.bigint "jurisdiction_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_registration_histories_on_district_id"
    t.index ["jurisdiction_id"], name: "index_registration_histories_on_jurisdiction_id"
  end

  create_table "registration_snapshots", force: :cascade do |t|
    t.date "snapshot_date"
    t.integer "total_registered"
    t.integer "registered_dem"
    t.integer "registered_rep"
    t.integer "registered_other"
    t.bigint "statistical_datum_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["statistical_datum_id"], name: "index_registration_snapshots_on_statistical_datum_id"
  end

  create_table "reports", force: :cascade do |t|
    t.date "period_begin"
    t.date "period_end"
    t.date "report_filed"
    t.float "period_receipts"
    t.float "period_disbursements"
    t.float "current_coh"
    t.float "current_debt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "candidate_id"
    t.bigint "committee_id"
    t.bigint "person_id"
    t.boolean "is_amended"
    t.integer "cycle"
    t.bigint "district_id"
    t.boolean "incumbent_report"
    t.boolean "candidate_report", default: true
    t.float "loans_received"
    t.boolean "officeholder_account", default: false
    t.string "pdf"
    t.index ["candidate_id"], name: "index_reports_on_candidate_id"
    t.index ["committee_id"], name: "index_reports_on_committee_id"
    t.index ["district_id"], name: "index_reports_on_district_id"
    t.index ["person_id"], name: "index_reports_on_person_id"
  end

  create_table "statistical_data", force: :cascade do |t|
    t.bigint "district_id"
    t.bigint "jurisdiction_id"
    t.integer "district_year"
    t.integer "measure_a_yes"
    t.integer "measure_a_no"
    t.integer "number_of_winners"
    t.integer "registered_2018"
    t.integer "voted_2018"
    t.integer "registered_2016"
    t.integer "voted_2016"
    t.integer "registered_2014"
    t.integer "voted_2014"
    t.integer "registered_2012"
    t.integer "voted_2012"
    t.integer "registered_2020"
    t.integer "voted_2020"
    t.integer "prop_6_yes"
    t.integer "prop_6_no"
    t.integer "prop_51_yes"
    t.integer "prop_51_no"
    t.integer "prop_62_yes"
    t.integer "prop_62_no"
    t.integer "prop_15_yes"
    t.integer "prop_15_no"
    t.integer "prop_16_yes"
    t.integer "prop_16_no"
    t.integer "prop_21_yes"
    t.integer "prop_21_no"
    t.float "obama_2012"
    t.float "romney_2012"
    t.float "trump_2016"
    t.float "clinton_2016"
    t.float "trump_2020"
    t.float "biden_2020"
    t.float "newsom_2018"
    t.float "cox_2018"
    t.float "brown_2014"
    t.float "kashkari_2014"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_statistical_data_on_district_id"
    t.index ["jurisdiction_id"], name: "index_statistical_data_on_jurisdiction_id"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.string "taggable_type"
    t.integer "taggable_id"
    t.string "tagger_type"
    t.integer "tagger_id"
    t.string "context", limit: 128
    t.datetime "created_at"
    t.index ["context"], name: "index_taggings_on_context"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_id", "taggable_type", "context"], name: "taggings_taggable_context_idx"
    t.index ["taggable_id", "taggable_type", "tagger_id", "context"], name: "taggings_idy"
    t.index ["taggable_id"], name: "index_taggings_on_taggable_id"
    t.index ["taggable_type"], name: "index_taggings_on_taggable_type"
    t.index ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type"
    t.index ["tagger_id"], name: "index_taggings_on_tagger_id"
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "updates", force: :cascade do |t|
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.string "stripe_id"
    t.string "stripe_subscription_id"
    t.string "first_name"
    t.string "last_name"
    t.string "card_last4"
    t.integer "card_exp_month"
    t.integer "card_exp_year"
    t.string "card_type"
    t.boolean "subscribed"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.boolean "notify_when_new_expenditure", default: true
    t.string "unsubscribe_hash"
    t.boolean "notify_when_new_report", default: true
    t.string "subscription_display"
    t.boolean "cancellation_pending", default: false
    t.boolean "free_account", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "candidates", "districts"
  add_foreign_key "committees", "candidates"
  add_foreign_key "committees", "jurisdictions"
  add_foreign_key "committees", "measures"
  add_foreign_key "committees", "people"
  add_foreign_key "districts", "former_offices"
  add_foreign_key "districts", "registration_histories"
  add_foreign_key "election_histories", "districts"
  add_foreign_key "elections", "districts"
  add_foreign_key "expenditures", "committees"
  add_foreign_key "expenditures", "districts"
  add_foreign_key "expenditures", "measures"
  add_foreign_key "expenditures", "people"
  add_foreign_key "former_offices", "districts"
  add_foreign_key "former_offices", "people"
  add_foreign_key "historical_candidates", "election_histories"
  add_foreign_key "historical_candidates", "people"
  add_foreign_key "historical_candidates", "people", column: "people_id"
  add_foreign_key "jurisdictions", "registration_histories"
  add_foreign_key "measures", "jurisdictions"
  add_foreign_key "people", "districts"
  add_foreign_key "people", "historical_candidates", column: "historical_candidates_id"
  add_foreign_key "registration_histories", "districts"
  add_foreign_key "registration_histories", "jurisdictions"
  add_foreign_key "registration_snapshots", "statistical_data"
  add_foreign_key "reports", "candidates"
  add_foreign_key "reports", "committees"
  add_foreign_key "reports", "districts"
  add_foreign_key "reports", "people"
  add_foreign_key "statistical_data", "districts"
  add_foreign_key "statistical_data", "jurisdictions"
  add_foreign_key "taggings", "tags"
end
