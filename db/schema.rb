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

ActiveRecord::Schema.define(version: 20160310160015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "list_files", force: :cascade do |t|
    t.string   "state",               limit: 2,                 null: false
    t.string   "upload_file_name",                              null: false
    t.integer  "upload_file_size",              default: 0
    t.string   "upload_content_type",                           null: false
    t.datetime "upload_updated_at"
    t.boolean  "active",                        default: false
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "upload_fingerprint"
  end

  add_index "list_files", ["state"], name: "index_list_files_on_state", using: :btree

  create_table "list_members", force: :cascade do |t|
    t.integer  "list_file_id"
    t.string   "number",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "list_members", ["list_file_id"], name: "index_list_members_on_list_file_id", using: :btree
  add_index "list_members", ["number"], name: "index_list_members_on_number", using: :btree

  create_table "list_queries", force: :cascade do |t|
    t.string   "input",      null: false
    t.string   "status",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "list_members", "list_files"
end
