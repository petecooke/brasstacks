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

ActiveRecord::Schema.define(version: 20140825230853) do

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
  end

  create_table "entries", force: true do |t|
    t.integer  "race_id"
    t.integer  "program_num"
    t.string   "name"
    t.integer  "age"
    t.string   "meds"
    t.string   "equip"
    t.float    "odds"
    t.string   "official_finish"
    t.integer  "speed_rating"
    t.string   "jockey_first_name"
    t.string   "jockey_last_name"
    t.string   "trainer_first_name"
    t.string   "trainer_last_name"
    t.string   "owner"
    t.string   "comment"
    t.float    "win_payoff"
    t.float    "place_payoff"
    t.float    "show_payoff"
    t.float    "show_payoff2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "races", force: true do |t|
    t.integer  "chart_id"
    t.integer  "number"
    t.string   "breed"
    t.string   "race_type"
    t.string   "restriction"
    t.string   "distance"
    t.string   "dist_unit"
    t.string   "surface"
    t.string   "condition"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
