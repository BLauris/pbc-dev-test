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

ActiveRecord::Schema.define(version: 20171026202241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string   "country_code",      default: "", null: false
    t.integer  "panel_provider_id",              null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "countries", ["panel_provider_id"], name: "index_countries_on_panel_provider_id", using: :btree

  create_table "location_groups", force: :cascade do |t|
    t.string   "name",              default: "", null: false
    t.integer  "country_id"
    t.integer  "panel_provider_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "location_groups", ["country_id"], name: "index_location_groups_on_country_id", using: :btree
  add_index "location_groups", ["panel_provider_id"], name: "index_location_groups_on_panel_provider_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",        default: "", null: false
    t.integer  "external_id"
    t.string   "secret_code"
    t.integer  "country_id",               null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "locations", ["country_id"], name: "index_locations_on_country_id", using: :btree
  add_index "locations", ["external_id"], name: "index_locations_on_external_id", using: :btree

  create_table "panel_providers", force: :cascade do |t|
    t.string   "code",           default: "", null: false
    t.integer  "price_in_cents",              null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "target_groups", force: :cascade do |t|
    t.string   "name",              default: "", null: false
    t.integer  "external_id"
    t.string   "secret_code"
    t.integer  "panel_provider_id"
    t.integer  "parent_id"
    t.integer  "lft",                            null: false
    t.integer  "rgt",                            null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "target_groups", ["lft"], name: "index_target_groups_on_lft", using: :btree
  add_index "target_groups", ["panel_provider_id"], name: "index_target_groups_on_panel_provider_id", using: :btree
  add_index "target_groups", ["parent_id"], name: "index_target_groups_on_parent_id", using: :btree
  add_index "target_groups", ["rgt"], name: "index_target_groups_on_rgt", using: :btree

  create_table "user_panel_providers", force: :cascade do |t|
    t.integer  "user_id",                       null: false
    t.integer  "panel_provider_id",             null: false
    t.integer  "active",            default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",            default: "", null: false
    t.string   "token"
    t.datetime "token_expires_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "balance_in_cents", default: 0,  null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["token"], name: "index_users_on_token", unique: true, using: :btree

end
