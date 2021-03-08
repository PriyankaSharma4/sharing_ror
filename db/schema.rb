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

ActiveRecord::Schema.define(version: 2021_03_07_121756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "location_shares", force: :cascade do |t|
    t.bigint "user_id"
    t.string "address", default: ""
    t.decimal "lat", precision: 15, scale: 10
    t.decimal "long", precision: 15, scale: 10
    t.boolean "is_public", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_location_shares_on_user_id"
  end

  create_table "shared_to_others", force: :cascade do |t|
    t.bigint "location_share_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["location_share_id"], name: "index_shared_to_others_on_location_share_id"
    t.index ["user_id"], name: "index_shared_to_others_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "location_shares", "users"
  add_foreign_key "shared_to_others", "location_shares"
  add_foreign_key "shared_to_others", "users"
end
