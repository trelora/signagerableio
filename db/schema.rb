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

ActiveRecord::Schema.define(version: 20160614195531) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.string "device_code"
    t.string "nickname"
    t.string "role"
    t.string "last_visit"
  end

  create_table "displays", force: :cascade do |t|
    t.integer "time"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "slides", force: :cascade do |t|
    t.string   "role"
    t.string   "ribbon"
    t.string   "ribbon_color"
    t.string   "title"
    t.string   "subtitle"
    t.string   "best_large_image"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "api_role"
  end

end
