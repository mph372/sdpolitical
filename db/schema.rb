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

ActiveRecord::Schema.define(version: 2020_07_14_184200) do

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
    t.string "support", default: "f"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "person_id"
    t.boolean "is_oppose", default: false
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
    t.index ["incumbent_id"], name: "index_districts_on_incumbent_id"
    t.index ["jurisdiction_id"], name: "index_districts_on_jurisdiction_id"
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
    t.boolean "is_support"
    t.boolean "is_amendment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "committee_id"
    t.bigint "district_id"
    t.string "election_type"
    t.integer "election_cycle"
    t.index ["committee_id"], name: "index_expenditures_on_committee_id"
    t.index ["district_id"], name: "index_expenditures_on_district_id"
    t.index ["measure_id"], name: "index_expenditures_on_measure_id"
    t.index ["person_id"], name: "index_expenditures_on_person_id"
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
    t.index ["jurisdiction_id"], name: "index_measures_on_jurisdiction_id"
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
    t.index ["district_id"], name: "index_people_on_district_id"
  end

  create_table "reports", force: :cascade do |t|
    t.date "period_begin"
    t.date "period_end"
    t.date "report_filed"
    t.integer "period_receipts"
    t.integer "period_disbursements"
    t.integer "current_coh"
    t.integer "current_debt"
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
    t.index ["candidate_id"], name: "index_reports_on_candidate_id"
    t.index ["committee_id"], name: "index_reports_on_committee_id"
    t.index ["district_id"], name: "index_reports_on_district_id"
    t.index ["person_id"], name: "index_reports_on_person_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "candidates", "districts"
  add_foreign_key "committees", "candidates"
  add_foreign_key "committees", "jurisdictions"
  add_foreign_key "committees", "measures"
  add_foreign_key "committees", "people"
  add_foreign_key "elections", "districts"
  add_foreign_key "expenditures", "committees"
  add_foreign_key "expenditures", "districts"
  add_foreign_key "expenditures", "measures"
  add_foreign_key "expenditures", "people"
  add_foreign_key "measures", "jurisdictions"
  add_foreign_key "people", "districts"
  add_foreign_key "reports", "candidates"
  add_foreign_key "reports", "committees"
  add_foreign_key "reports", "districts"
  add_foreign_key "reports", "people"
  add_foreign_key "taggings", "tags"
end
