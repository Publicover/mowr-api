# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_01_14_084000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "line1"
    t.string "line2"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.string "name"
    t.integer "driveway"
    t.integer "user_id"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "base_locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "longitude", precision: 10, scale: 6
    t.decimal "latitude", precision: 10, scale: 6
    t.string "zip"
    t.string "state"
    t.string "city"
    t.string "line2"
    t.string "line1"
  end

  create_table "daily_routes", force: :cascade do |t|
    t.integer "addresses_in_order", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "early_birds", force: :cascade do |t|
    t.integer "priority", default: 1
    t.bigint "address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["address_id"], name: "index_early_birds_on_address_id"
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string "nickname"
    t.string "stripe_pm_id"
    t.string "stripe_user_id"
    t.string "stripe_token"
    t.string "brand"
    t.string "last4"
    t.string "exp_month"
    t.string "exp_year"
    t.integer "status", default: 1
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_payment_methods_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.integer "cost_in_cents"
    t.string "stripe_charge_id"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "plows", force: :cascade do |t|
    t.string "licence_plate"
    t.string "year"
    t.string "color"
    t.string "make"
    t.string "model"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_plows_on_user_id"
  end

  create_table "service_deliveries", force: :cascade do |t|
    t.bigint "address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "total_cost", precision: 5, scale: 2
    t.integer "status", default: 0
    t.index ["address_id"], name: "index_service_deliveries_on_address_id"
  end

  create_table "service_requests", force: :cascade do |t|
    t.bigint "address_id", null: false
    t.integer "service_ids", default: [], array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.decimal "service_subtotal", precision: 5, scale: 2
    t.index ["address_id"], name: "index_service_requests_on_address_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "price_per_inch_of_snow", precision: 5, scale: 2
    t.integer "price_per_driveway", default: [], array: true
  end

  create_table "size_estimates", force: :cascade do |t|
    t.decimal "square_footage", precision: 6, scale: 2
    t.bigint "address_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0
    t.index ["address_id"], name: "index_size_estimates_on_address_id"
  end

  create_table "snow_accumulations", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "inches"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "f_name"
    t.string "l_name"
    t.string "password_digest"
    t.integer "role"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "phone"
    t.string "stripe_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "early_birds", "addresses", on_delete: :cascade
  add_foreign_key "payment_methods", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "plows", "users"
  add_foreign_key "service_deliveries", "addresses"
  add_foreign_key "service_requests", "addresses"
  add_foreign_key "size_estimates", "addresses"
end
