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

ActiveRecord::Schema[7.1].define(version: 2025_08_08_181729) do
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
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "cuisines", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cuisines_restaurants", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.bigint "cuisine_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cuisine_id"], name: "index_cuisines_restaurants_on_cuisine_id"
    t.index ["restaurant_id"], name: "index_cuisines_restaurants_on_restaurant_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_favorites_on_restaurant_id"
    t.index ["user_id", "restaurant_id"], name: "index_favorites_on_user_id_and_restaurant_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_follows_on_restaurant_id"
    t.index ["user_id", "restaurant_id"], name: "index_follows_on_user_id_and_restaurant_id", unique: true
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "restaurant_id", null: false
    t.bigint "table_id", null: false
    t.datetime "reservation_time", null: false
    t.integer "party_size", null: false
    t.string "status", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_reservations_on_restaurant_id"
    t.index ["table_id"], name: "index_reservations_on_table_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "restaurant_hours", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.integer "day_of_week", null: false
    t.time "opens_at", null: false
    t.time "closes_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_restaurant_hours_on_restaurant_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.string "prefecture"
    t.string "district"
    t.text "description"
    t.string "phone_number"
    t.string "website"
    t.integer "total_tables"
    t.integer "followers_count", default: 0
    t.integer "favorites_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.integer "lunch_price"
    t.integer "dinner_price"
    t.string "about"
    t.index ["user_id"], name: "index_restaurants_on_user_id"
  end

  create_table "tables", force: :cascade do |t|
    t.bigint "restaurant_id", null: false
    t.integer "number"
    t.integer "seats"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_tables_on_restaurant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.integer "role", default: 0, null: false
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jti", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "cuisines_restaurants", "cuisines"
  add_foreign_key "cuisines_restaurants", "restaurants"
  add_foreign_key "favorites", "restaurants"
  add_foreign_key "favorites", "users"
  add_foreign_key "follows", "restaurants"
  add_foreign_key "follows", "users"
  add_foreign_key "reservations", "restaurants"
  add_foreign_key "reservations", "tables"
  add_foreign_key "reservations", "users"
  add_foreign_key "restaurant_hours", "restaurants"
  add_foreign_key "restaurants", "users"
  add_foreign_key "tables", "restaurants"
end
