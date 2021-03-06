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

ActiveRecord::Schema.define(version: 20150415204511) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "occupations", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "description"
    t.string   "address"
    t.integer  "availability_status"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "user_vacancies", force: :cascade do |t|
    t.integer  "vacancy_id"
    t.integer  "user_id"
    t.integer  "acceptance_status"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.integer  "occupation_id"
    t.integer  "role_identity"
    t.string   "fullname"
    t.string   "rfc"
    t.string   "mobile_phone_number"
    t.string   "home_phone_number"
    t.string   "linkedin_url"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vacancies", force: :cascade do |t|
    t.integer  "occupation_id"
    t.integer  "project_id"
    t.string   "description"
    t.float    "hourly_wage"
    t.float    "hours_required"
    t.integer  "availability_status"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_foreign_key "projects", "users"
  add_foreign_key "user_vacancies", "users"
  add_foreign_key "user_vacancies", "vacancies"
  add_foreign_key "users", "occupations"
  add_foreign_key "vacancies", "occupations"
  add_foreign_key "vacancies", "projects"
end
