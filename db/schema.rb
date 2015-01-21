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

ActiveRecord::Schema.define(version: 20150121112905) do

  create_table "languages", force: true do |t|
    t.string   "name"
    t.integer  "level"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "sort"
  end

  add_index "languages", ["name"], name: "index_languages_on_name"
  add_index "languages", ["sort"], name: "index_languages_on_sort"
  add_index "languages", ["user_id"], name: "index_languages_on_user_id"

  create_table "microposts", force: true do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id"

  create_table "pictures", force: true do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.boolean  "is_public",      default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "pictures", ["imageable_id"], name: "index_pictures_on_imageable_id"

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "gender"
    t.date     "birthday"
    t.string   "region"
    t.string   "contury"
    t.string   "city"
    t.text     "introduce"
    t.string   "interests"
    t.string   "status"
    t.boolean  "newbie",            default: true
  end

  add_index "users", ["contury", "city"], name: "index_users_on_contury_and_city"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["gender"], name: "index_users_on_gender"

end
