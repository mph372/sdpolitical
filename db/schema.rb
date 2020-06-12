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

ActiveRecord::Schema.define(version: 2020_06_12_214734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.index ["jurisdiction_id"], name: "index_districts_on_jurisdiction_id"
  end

  create_table "incumbents", force: :cascade do |t|
    t.bigint "district_id"
    t.string "title"
    t.string "first_name"
    t.string "last_name"
    t.date "birth_date"
    t.string "party"
    t.integer "first_elected"
    t.string "prior_elected"
    t.integer "salary"
    t.string "professional_career"
    t.integer "congressional_district"
    t.integer "assembly_district"
    t.integer "senate_district"
    t.integer "supe_district"
    t.string "birth_place"
    t.string "email"
    t.string "twitter"
    t.string "facebook"
    t.string "phone"
    t.integer "term"
    t.boolean "on_ballot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image"
    t.integer "term_expires"
    t.integer "seeking_office"
    t.string "official_website"
    t.string "campaign_website"
    t.index ["district_id"], name: "index_incumbents_on_district_id"
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
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "incumbent_id"
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
    t.index ["candidate_id"], name: "index_reports_on_candidate_id"
    t.index ["incumbent_id"], name: "index_reports_on_incumbent_id"
  end

  add_foreign_key "candidates", "districts"
  add_foreign_key "incumbents", "districts"
  add_foreign_key "reports", "candidates"
  add_foreign_key "reports", "incumbents"
end
