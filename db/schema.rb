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

ActiveRecord::Schema.define(version: 20131001162933) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "nonprofits", force: true do |t|
    t.string   "name",                null: false
    t.string   "ein_num",             null: false
    t.string   "date_founded"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "street_address"
    t.string   "street_address_2"
    t.string   "state",               null: false
    t.string   "city",                null: false
    t.string   "zipcode"
    t.string   "email_address"
    t.string   "website_string"
    t.text     "description_mission", null: false
    t.string   "cause",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "opportunities", force: true do |t|
    t.text     "description",      null: false
    t.text     "current_stack",    null: false
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.text     "extra_details"
    t.string   "duration"
    t.string   "time_commitment"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "headline",         null: false
    t.string   "zipcode"
    t.integer  "nonprofit_id",     null: false
    t.text     "application_info", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "opportunity_skills", force: true do |t|
    t.integer  "skill_id",       null: false
    t.integer  "opportunity_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_skills", force: true do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "city",                                null: false
    t.string   "state",                               null: false
    t.string   "zipcode",                             null: false
    t.text     "about_me"
    t.string   "current_company"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
