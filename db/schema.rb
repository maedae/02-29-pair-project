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

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", force: :cascade do |t|
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "address"
    t.string   "apt_no"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "landlord_name"
    t.string   "building_image"
    t.string   "move_in"
    t.string   "move_out"
    t.boolean  "locked"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "items", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.text     "description"
    t.integer  "condition"
    t.integer  "room_id"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "photos", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "item_id"
    t.string   "image"
  end

  create_table "renters", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.integer  "building_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.string   "room_image"
    t.string   "location"
    t.integer  "building_id"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

end
