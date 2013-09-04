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

ActiveRecord::Schema.define(version: 20130904150604) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.string   "subject"
    t.date     "date"
    t.text     "note"
    t.boolean  "done"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deal_id"
    t.string   "type"
  end

  add_index "activities", ["deal_id"], name: "index_activities_on_deal_id", using: :btree

  create_table "careers", force: true do |t|
    t.date     "from"
    t.date     "to"
    t.string   "department"
    t.string   "title"
    t.string   "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.integer  "owner_id"
    t.string   "address"
    t.string   "remarks"
    t.string   "abbreviation"
    t.string   "url"
    t.integer  "organization_id"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["organization_id"], name: "index_contacts_on_organization_id", using: :btree
  add_index "contacts", ["owner_id"], name: "index_contacts_on_owner_id", using: :btree

  create_table "deals", force: true do |t|
    t.date     "start_date"
    t.date     "order_date"
    t.date     "accept_date"
    t.integer  "amount"
    t.string   "accuracy"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
  end

  add_index "deals", ["organization_id"], name: "index_deals_on_organization_id", using: :btree

  create_table "deals_people", id: false, force: true do |t|
    t.integer "deal_id"
    t.integer "person_id"
  end

  create_table "deals_users", id: false, force: true do |t|
    t.integer "deal_id"
    t.integer "user_id"
  end

  create_table "updates", force: true do |t|
    t.string   "type"
    t.date     "timestamp"
    t.string   "message"
    t.string   "subject_type"
    t.integer  "subject_id"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "activity_id"
  end

  add_index "updates", ["activity_id"], name: "index_updates_on_activity_id", using: :btree
  add_index "updates", ["user_id"], name: "index_updates_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
