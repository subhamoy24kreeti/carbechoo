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

ActiveRecord::Schema.define(version: 2021_09_19_154351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "brands", force: :cascade do |t|
    t.string "brand_name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "buyer_appointments", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "status", default: "processing", null: false
    t.date "scheduled_date"
    t.time "scheduled_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "seller_appointment_id"
    t.index ["seller_appointment_id"], name: "index_buyer_appointments_on_seller_appointment_id"
    t.index ["user_id"], name: "index_buyer_appointments_on_user_id"
  end

  create_table "car_models", force: :cascade do |t|
    t.bigint "brand_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["brand_id"], name: "index_car_models_on_brand_id"
  end

  create_table "car_registration_years", force: :cascade do |t|
    t.string "range1", null: false
    t.string "range2", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.bigint "state_id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["state_id"], name: "index_cities_on_states_id"
  end

  create_table "cost_ranges", force: :cascade do |t|
    t.string "quality", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "currency", limit: 12, null: false
    t.bigint "range1", null: false
    t.bigint "range2", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name", null: false
    t.string "code"
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
    t.bigint "brand_id", null: false
    t.bigint "car_model_id", null: false
    t.bigint "car_registration_id", null: false
    t.bigint "killometer_driven_id", null: false
    t.bigint "car_variant_id", null: false
    t.bigint "city_id", null: false
    t.bigint "state_id", null: false
    t.bigint "country_id", null: false
    t.string "zip_code"
    t.bigint "cost_range_id"
    t.string "year_of_buy"
    t.bigint "price"
    t.string "description"
    t.string "status", default: "processing", null: false
    t.date "scheduled_date"
    t.time "scheduled_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "currency", limit: 12
    t.index ["brand_id"], name: "index_seller_appointments_on_brand_id"
    t.index ["car_model_id"], name: "index_seller_appointments_on_car_model_id"
    t.index ["car_registration_id"], name: "index_seller_appointments_on_car_registration_id"
    t.index ["car_variant_id"], name: "index_seller_appointments_on_car_variant_id"
    t.index ["city_id"], name: "index_seller_appointments_on_city_id"
    t.index ["cost_range_id"], name: "index_seller_appointments_on_cost_range_id"
    t.index ["country_id"], name: "index_seller_appointments_on_country_id"
    t.index ["killometer_driven_id"], name: "index_seller_appointments_on_killometer_driven_id"
    t.index ["state_id"], name: "index_seller_appointments_on_state_id"
    t.index ["user_id"], name: "index_seller_appointments_on_user_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["country_id"], name: "index_states_on_countries_id"
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
    t.boolean "email_confirmed"
    t.string "confirm_token_email"
    t.boolean "phone_confirm"
    t.string "confirm_token_phone"
    t.datetime "expired_token_email_at"
    t.datetime "expired_token_phone_at"
    t.text "street"
    t.text "city"
    t.text "state"
    t.string "country"
    t.float "longitude"
    t.float "latitude"
    t.text "zip_code"
    t.string "password_reset_token"
    t.datetime "password_reset_token_sent_at"
    t.text "about"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "buyer_appointments", "seller_appointments"
  add_foreign_key "buyer_appointments", "users"
  add_foreign_key "car_models", "brands"
  add_foreign_key "cities", "states"
  add_foreign_key "seller_appointments", "brands"
  add_foreign_key "seller_appointments", "car_models"
  add_foreign_key "seller_appointments", "car_registrations"
  add_foreign_key "seller_appointments", "car_variants"
  add_foreign_key "seller_appointments", "cities"
  add_foreign_key "seller_appointments", "cost_ranges"
  add_foreign_key "seller_appointments", "countries"
  add_foreign_key "seller_appointments", "killometer_drivens"
  add_foreign_key "seller_appointments", "states"
  add_foreign_key "seller_appointments", "users"
  add_foreign_key "states", "countries"
end
