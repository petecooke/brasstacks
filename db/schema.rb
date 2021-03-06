# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141108053504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "charts", force: true do |t|
    t.date     "race_date"
    t.text     "track_name"
    t.integer  "race_number"
    t.text     "entry_name"
    t.integer  "official_finish"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "race_type"
    t.string   "chart"
    t.string   "fingerprint"
  end

  add_index "charts", ["fingerprint"], name: "index_charts_on_fingerprint", using: :btree

  create_table "entries", force: true do |t|
    t.integer  "race_id"
    t.integer  "program_num"
    t.integer  "age"
    t.string   "meds"
    t.string   "equip"
    t.float    "odds"
    t.string   "official_finish"
    t.integer  "speed_rating"
    t.string   "comment"
    t.float    "win_payoff"
    t.float    "place_payoff"
    t.float    "show_payoff"
    t.float    "show_payoff2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "jockey_id"
    t.integer  "trainer_id"
    t.integer  "owner_id"
    t.integer  "horse_id"
  end

  add_index "entries", ["horse_id"], name: "index_entries_on_horse_id", using: :btree
  add_index "entries", ["jockey_id"], name: "index_entries_on_jockey_id", using: :btree
  add_index "entries", ["owner_id"], name: "index_entries_on_owner_id", using: :btree
  add_index "entries", ["trainer_id"], name: "index_entries_on_trainer_id", using: :btree

  create_table "horses", force: true do |t|
    t.string   "horse_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jockeys", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "suffix"
    t.integer  "key"
    t.string   "jockey_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "owners", force: true do |t|
    t.string   "owner_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "race_levels", force: true do |t|
    t.string   "race_type"
    t.string   "restriction"
    t.string   "distance"
    t.string   "dist_unit"
    t.string   "surface"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "class_rating"
  end

  create_table "races", force: true do |t|
    t.integer  "chart_id"
    t.integer  "number"
    t.string   "breed"
    t.string   "condition"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "race_level_id"
    t.date     "race_date"
    t.string   "track_name"
    t.string   "meet_season"
  end

  add_index "races", ["race_level_id"], name: "index_races_on_race_level_id", using: :btree

  create_table "trainers", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "suffix"
    t.integer  "key"
    t.string   "trainer_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
