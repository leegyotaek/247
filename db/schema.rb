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

ActiveRecord::Schema.define(version: 20150130170223) do

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "status"
    t.datetime "accepted_at"
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id"
  add_index "friendships", ["status"], name: "index_friendships_on_status"
  add_index "friendships", ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id"

  create_table "languages", force: :cascade do |t|
    t.string   "language"
    t.integer  "level"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "sort"
  end

  add_index "languages", ["language"], name: "index_languages_on_language"
  add_index "languages", ["sort"], name: "index_languages_on_sort"
  add_index "languages", ["user_id"], name: "index_languages_on_user_id"

  create_table "microposts", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "picture"
  end

  add_index "microposts", ["user_id", "created_at"], name: "index_microposts_on_user_id_and_created_at"
  add_index "microposts", ["user_id"], name: "index_microposts_on_user_id"

  create_table "pictures", force: :cascade do |t|
    t.string   "name"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.boolean  "is_public",      default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "pictures", ["imageable_id"], name: "index_pictures_on_imageable_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "matcher_id"
    t.integer  "matched_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "relationships", ["matched_id"], name: "index_relationships_on_matched_id"
  add_index "relationships", ["matcher_id", "matched_id"], name: "index_relationships_on_matcher_id_and_matched_id", unique: true
  add_index "relationships", ["matcher_id"], name: "index_relationships_on_matcher_id"

  create_table "users", force: :cascade do |t|
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
    t.string   "country"
    t.string   "city"
    t.text     "introduce"
    t.string   "interests"
    t.string   "status"
    t.boolean  "newbie",            default: true
    t.string   "matching_lan"
    t.integer  "matching_age_from"
    t.integer  "matching_age_to"
    t.string   "matching_interest"
  end

  add_index "users", ["country", "city"], name: "index_users_on_country_and_city"
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["gender"], name: "index_users_on_gender"

end
