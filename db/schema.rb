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

ActiveRecord::Schema.define(version: 2021_08_27_154238) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string "brand_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "buyer_appointments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "seller_user_id", null: false
    t.string "status", default: "processing", null: false
    t.date "scheduled_date"
    t.time "scheduled_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["seller_user_id"], name: "index_buyer_appointments_on_seller_user_id"
    t.index ["user_id"], name: "index_buyer_appointments_on_user_id"
  end

  create_table "car_models", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_car_models_on_brand_id"
  end

  create_table "car_registrations", force: :cascade do |t|
    t.string "state_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "car_variants", force: :cascade do |t|
    t.string "variant", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "city", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "killometer_drivens", force: :cascade do |t|
    t.string "killometer_range", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "seller_appointments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "status", default: "processing", null: false
    t.date "scheduled_date"
    t.time "scheduled_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_seller_appointments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "username"
    t.string "password_digest", null: false
    t.string "email", null: false
    t.string "phone"
    t.text "address"
    t.string "avatar"
    t.string "cover_image"
    t.string "role", null: false
    t.integer "email_verified", limit: 2
    t.integer "phone_verified", limit: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "buyer_appointments", "users"
  add_foreign_key "buyer_appointments", "users", column: "seller_user_id"
  add_foreign_key "car_models", "brands"
  add_foreign_key "seller_appointments", "users"
end
