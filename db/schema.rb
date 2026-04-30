# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2026_04_29_231831) do
  create_table "business_trips", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "site_id", null: false
    t.date "started_at"
    t.date "ended_at"
    t.string "destination"
    t.text "purpose"
    t.text "report"
    t.decimal "expenses"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_business_trips_on_site_id"
    t.index ["user_id"], name: "index_business_trips_on_user_id"
  end

  create_table "inspections", force: :cascade do |t|
    t.integer "site_id", null: false
    t.integer "user_id", null: false
    t.datetime "inspected_at"
    t.integer "status"
    t.text "result"
    t.text "remarks"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["site_id"], name: "index_inspections_on_site_id"
    t.index ["user_id"], name: "index_inspections_on_user_id"
  end

  create_table "sites", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "status"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "business_trips", "sites"
  add_foreign_key "business_trips", "users"
  add_foreign_key "inspections", "sites"
  add_foreign_key "inspections", "users"
end
