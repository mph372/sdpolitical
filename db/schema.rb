# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_10_28_162110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.date "period_begin"
    t.date "period_end"
    t.string "current_cycle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin_mode", default: true
  end

  create_table "blog_post_tags", force: :cascade do |t|
    t.bigint "blog_post_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["blog_post_id"], name: "index_blog_post_tags_on_blog_post_id"
    t.index ["tag_id"], name: "index_blog_post_tags_on_tag_id"
  end

  create_table "blog_posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "publish_date"
    t.string "status"
    t.text "excerpt"
    t.string "slug"
    t.index ["slug"], name: "index_blog_posts_on_slug", unique: true
  end

  create_table "campaigns", force: :cascade do |t|
    t.bigint "district_id"
    t.date "election_date"
    t.string "election_type"
    t.integer "number_of_winners"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_votes"
    t.bigint "itemized_expenditures_id"
    t.string "campaignable_type"
    t.bigint "campaignable_id"
    t.index ["campaignable_type", "campaignable_id"], name: "index_campaigns_on_campaignable"
    t.index ["district_id"], name: "index_campaigns_on_district_id"
    t.index ["itemized_expenditures_id"], name: "index_campaigns_on_itemized_expenditures_id"
  end

  create_table "candidate_committees", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "report_id"
    t.string "name"
    t.string "cycle"
    t.string "status"
    t.boolean "primary_committee", default: false
    t.bigint "candidate_id"
    t.string "fec_id"
    t.index ["candidate_id"], name: "index_candidate_committees_on_candidate_id"
    t.index ["person_id"], name: "index_candidate_committees_on_person_id"
    t.index ["report_id"], name: "index_candidate_committees_on_report_id"
  end

  create_table "candidates", force: :cascade do |t|
    t.bigint "campaign_id"
    t.bigint "person_id"
    t.string "ballot_status"
    t.string "campaign_email"
    t.string "campaign_phone"
    t.string "campaign_twitter"
    t.string "campaign_facebook"
    t.string "campaign_website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "candidate_committee_id"
    t.string "first_name"
    t.string "last_name"
    t.integer "votes"
    t.string "party_endorsement"
    t.string "party_registration"
    t.boolean "active"
    t.string "ballot_title"
    t.string "display_name"
    t.index ["campaign_id"], name: "index_candidates_on_campaign_id"
    t.index ["candidate_committee_id"], name: "index_candidates_on_candidate_committee_id"
    t.index ["person_id"], name: "index_candidates_on_person_id"
  end

  create_table "contestant_updates", force: :cascade do |t|
    t.integer "mail_ballots_votes"
    t.integer "vote_center_ballots_votes"
    t.integer "provisional_votes"
    t.integer "total_votes"
    t.integer "number_of_precincts"
    t.integer "precincts_reported"
    t.integer "ballots_cast"
    t.bigint "contestant_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "vote_type"
    t.index ["contestant_id"], name: "index_contestant_updates_on_contestant_id"
  end

  create_table "contestants", force: :cascade do |t|
    t.string "name"
    t.string "party"
    t.bigint "contest_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contest_id"], name: "index_contestants_on_contest_id"
  end

  create_table "contests", force: :cascade do |t|
    t.string "name"
    t.bigint "election_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.integer "vote_for"
    t.index ["election_id"], name: "index_contests_on_election_id"
    t.index ["slug"], name: "index_contests_on_slug", unique: true
    t.index ["vote_for"], name: "index_contests_on_vote_for"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.string "district"
    t.bigint "jurisdiction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "at_large_district", default: false
    t.integer "term_expires"
    t.integer "number_of_winners"
    t.boolean "is_seat", default: false
    t.boolean "is_area", default: false
    t.bigint "registration_history_id"
    t.bigint "former_office_id"
    t.bigint "person_id"
    t.string "district_title"
    t.boolean "archived", default: false
    t.string "note"
    t.string "district_map"
    t.string "google_maps_url"
    t.index ["former_office_id"], name: "index_districts_on_former_office_id"
    t.index ["jurisdiction_id"], name: "index_districts_on_jurisdiction_id"
    t.index ["person_id"], name: "index_districts_on_person_id"
    t.index ["registration_history_id"], name: "index_districts_on_registration_history_id"
  end

  create_table "election_updates", force: :cascade do |t|
    t.integer "ballots_cast"
    t.integer "mail_ballots"
    t.integer "vote_center_ballots"
    t.integer "registered_voters"
    t.bigint "election_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "ballots_outstanding"
    t.index ["election_id"], name: "index_election_updates_on_election_id"
  end

  create_table "elections", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "election_date"
    t.string "name"
    t.string "slug"
    t.index ["slug"], name: "index_elections_on_slug", unique: true
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
    t.boolean "at_large", default: false
    t.bigint "jurisdiction_id"
    t.string "title"
    t.index ["district_id"], name: "index_former_offices_on_district_id"
    t.index ["jurisdiction_id"], name: "index_former_offices_on_jurisdiction_id"
    t.index ["person_id"], name: "index_former_offices_on_person_id"
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
    t.boolean "archived", default: false
    t.string "logo"
    t.boolean "at_large_districts"
    t.string "google_maps_url"
    t.index ["registration_history_id"], name: "index_jurisdictions_on_registration_history_id"
  end

  create_table "people", force: :cascade do |t|
    t.bigint "district_id"
    t.string "title"
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.string "party"
    t.string "professional_career"
    t.integer "congressional_district"
    t.integer "assembly_district"
    t.integer "senate_district"
    t.integer "supe_district"
    t.string "email"
    t.string "twitter"
    t.string "facebook"
    t.integer "term"
    t.string "image"
    t.string "official_website"
    t.string "campaign_website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "bio"
    t.boolean "is_appointed"
    t.string "linkedin_url"
    t.bigint "historical_candidates_id"
    t.boolean "archived", default: false
    t.boolean "active", default: true
    t.index ["district_id"], name: "index_people_on_district_id"
    t.index ["historical_candidates_id"], name: "index_people_on_historical_candidates_id"
  end

  create_table "people_districts", id: false, force: :cascade do |t|
    t.bigint "district_id"
    t.bigint "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_people_districts_on_district_id"
    t.index ["person_id"], name: "index_people_districts_on_person_id"
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
    t.string "district_code"
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
    t.bigint "committee_id"
    t.boolean "is_amended"
    t.float "loans_received"
    t.string "pdf"
    t.bigint "candidate_committee_id"
    t.bigint "import_id"
    t.float "period_monetary_receipts"
    t.float "period_nonmonetary_receipts"
    t.index ["candidate_committee_id"], name: "index_reports_on_candidate_committee_id"
    t.index ["committee_id"], name: "index_reports_on_committee_id"
    t.index ["import_id"], name: "index_reports_on_import_id"
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
    t.float "white"
    t.float "hispanic"
    t.float "black"
    t.float "asian"
    t.float "native"
    t.float "pacific"
    t.integer "total_population"
    t.float "newsom_2022"
    t.float "dahle_2022"
    t.integer "prop_1_yes"
    t.integer "prop_1_no"
    t.integer "registered_2022"
    t.integer "voted_2022"
    t.index ["district_id"], name: "index_statistical_data_on_district_id"
    t.index ["jurisdiction_id"], name: "index_statistical_data_on_jurisdiction_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "blog_post_tags", "blog_posts"
  add_foreign_key "blog_post_tags", "tags"
  add_foreign_key "campaigns", "districts"
  add_foreign_key "candidate_committees", "candidates"
  add_foreign_key "candidate_committees", "people"
  add_foreign_key "candidate_committees", "reports"
  add_foreign_key "candidates", "campaigns"
  add_foreign_key "candidates", "candidate_committees"
  add_foreign_key "candidates", "people"
  add_foreign_key "contestant_updates", "contestants"
  add_foreign_key "contestants", "contests"
  add_foreign_key "contests", "elections"
  add_foreign_key "districts", "former_offices"
  add_foreign_key "districts", "jurisdictions"
  add_foreign_key "districts", "people"
  add_foreign_key "election_updates", "elections"
  add_foreign_key "former_offices", "districts"
  add_foreign_key "former_offices", "jurisdictions"
  add_foreign_key "former_offices", "people"
  add_foreign_key "people", "districts"
  add_foreign_key "people_districts", "districts"
  add_foreign_key "people_districts", "people"
  add_foreign_key "registration_snapshots", "statistical_data"
  add_foreign_key "reports", "candidate_committees"
  add_foreign_key "statistical_data", "districts"
  add_foreign_key "statistical_data", "jurisdictions"
end
