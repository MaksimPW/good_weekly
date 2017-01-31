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

ActiveRecord::Schema.define(version: 20170131045737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "author"
    t.text     "comment"
    t.integer  "rating"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_books_on_user_id", using: :btree
  end

  create_table "books_good_weeks", id: false, force: :cascade do |t|
    t.integer "book_id",      null: false
    t.integer "good_week_id", null: false
    t.index ["book_id", "good_week_id"], name: "index_books_good_weeks_on_book_id_and_good_week_id", using: :btree
    t.index ["good_week_id", "book_id"], name: "index_books_good_weeks_on_good_week_id_and_book_id", using: :btree
  end

  create_table "good_weeks", force: :cascade do |t|
    t.date     "monday",     null: false
    t.text     "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_good_weeks_on_user_id", using: :btree
  end

  create_table "good_weeks_people", id: false, force: :cascade do |t|
    t.integer "person_id",    null: false
    t.integer "good_week_id", null: false
    t.index ["good_week_id", "person_id"], name: "index_good_weeks_people_on_good_week_id_and_person_id", using: :btree
    t.index ["person_id", "good_week_id"], name: "index_good_weeks_people_on_person_id_and_good_week_id", using: :btree
  end

  create_table "people", force: :cascade do |t|
    t.string   "fio"
    t.date     "birthday"
    t.text     "description"
    t.text     "note"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_people_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "books", "users"
  add_foreign_key "good_weeks", "users"
  add_foreign_key "people", "users"
end
