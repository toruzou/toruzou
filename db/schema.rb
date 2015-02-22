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

ActiveRecord::Schema.define(version: 20150118112113) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.text     "note"
    t.boolean  "done"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "deal_id"
    t.string   "action"
    t.integer  "organization_id"
    t.datetime "deleted_at"
  end

  add_index "activities", ["deal_id"], name: "index_activities_on_deal_id", using: :btree
  add_index "activities", ["organization_id"], name: "index_activities_on_organization_id", using: :btree

  create_table "attachments", force: true do |t|
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.integer  "attachment",      null: false
    t.string   "name"
    t.string   "content_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "comments"
  end

  add_index "attachments", ["attachable_id"], name: "index_attachments_on_attachable_id", using: :btree

  create_table "audits", force: true do |t|
    t.integer  "auditable_id"
    t.string   "auditable_type"
    t.integer  "user_id"
    t.string   "user_type"
    t.text     "modifications"
    t.string   "action"
    t.string   "tag"
    t.integer  "version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "audits", ["action"], name: "index_audits_on_action", using: :btree
  add_index "audits", ["auditable_id", "auditable_type", "version"], name: "auditable_version_idx", using: :btree
  add_index "audits", ["auditable_id", "auditable_type"], name: "auditable_index", using: :btree
  add_index "audits", ["created_at"], name: "index_audits_on_created_at", using: :btree
  add_index "audits", ["tag"], name: "index_audits_on_tag", using: :btree
  add_index "audits", ["user_id", "user_type"], name: "user_index", using: :btree

  create_table "careers", force: true do |t|
    t.date     "from_date"
    t.date     "to_date"
    t.string   "department"
    t.string   "title"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "person_id"
  end

  add_index "careers", ["person_id"], name: "index_careers_on_person_id", using: :btree

  create_table "contacts", force: true do |t|
    t.string   "type"
    t.string   "name"
    t.integer  "owner_id"
    t.string   "address"
    t.text     "remarks"
    t.string   "abbreviation"
    t.string   "url"
    t.integer  "organization_id"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "contacts", ["organization_id"], name: "index_contacts_on_organization_id", using: :btree
  add_index "contacts", ["owner_id"], name: "index_contacts_on_owner_id", using: :btree

  create_table "deals", force: true do |t|
    t.date     "start_date"
    t.date     "accept_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "organization_id"
    t.string   "name"
    t.integer  "pm_id"
    t.integer  "sales_id"
    t.integer  "contact_id"
    t.datetime "deleted_at"
    t.string   "category"
    t.string   "project_type"
  end

  add_index "deals", ["contact_id"], name: "index_deals_on_contact_id", using: :btree
  add_index "deals", ["organization_id"], name: "index_deals_on_organization_id", using: :btree
  add_index "deals", ["pm_id"], name: "index_deals_on_pm_id", using: :btree
  add_index "deals", ["sales_id"], name: "index_deals_on_sales_id", using: :btree

  create_table "followings", force: true do |t|
    t.integer  "user_id"
    t.integer  "followable_id"
    t.string   "followable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followings", ["followable_id"], name: "index_followings_on_followable_id", using: :btree
  add_index "followings", ["user_id"], name: "index_followings_on_user_id", using: :btree

  create_table "notes", force: true do |t|
    t.integer "subject_id"
    t.string  "subject_type"
    t.text    "message"
  end

  create_table "participants", force: true do |t|
    t.integer "activity_id"
    t.integer "participable_id"
    t.string  "participable_type"
  end

  add_index "participants", ["activity_id"], name: "index_participants_on_activity_id", using: :btree
  add_index "participants", ["participable_id"], name: "index_participants_on_participable_id", using: :btree

  create_table "sales_projections", force: true do |t|
    t.integer  "deal_id"
    t.integer  "year"
    t.integer  "period"
    t.integer  "amount"
    t.text     "remarks"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "profit_amount"
    t.float    "profit_rate"
    t.string   "obic_no"
    t.date     "start_date"
    t.date     "end_date"
    t.date     "order_date"
    t.string   "status"
    t.integer  "accuracy"
  end

  add_index "sales_projections", ["deal_id"], name: "index_sales_projections_on_deal_id", using: :btree

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "updates", force: true do |t|
    t.integer  "audit_id"
    t.integer  "receivable_id"
    t.string   "receivable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  add_index "updates", ["audit_id"], name: "index_updates_on_audit_id", using: :btree
  add_index "updates", ["receivable_id", "receivable_type"], name: "index_updates_on_receivable_id_and_receivable_type", using: :btree

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
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
