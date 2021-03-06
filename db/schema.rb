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

ActiveRecord::Schema.define(version: 20170330030054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookmarks", force: :cascade do |t|
    t.string   "name"
    t.text     "url"
    t.string   "short_url"
    t.integer  "site_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.text     "tags",       default: [],              array: true
    t.index ["site_id"], name: "index_bookmarks_on_site_id", using: :btree
    t.index ["tags"], name: "index_bookmarks_on_tags", using: :gin
  end

  create_table "sites", force: :cascade do |t|
    t.text     "url"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "bookmarks_count", default: 0
  end

  add_foreign_key "bookmarks", "sites"
end
