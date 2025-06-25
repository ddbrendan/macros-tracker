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

ActiveRecord::Schema[8.0].define(version: 2025_06_25_082627) do
  create_table "entries", force: :cascade do |t|
    t.string "food_name"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "food_id"
    t.decimal "grams", precision: 6, scale: 1
    t.decimal "custom_calories_per_100g"
    t.decimal "custom_carbs_per_100g"
    t.decimal "custom_protein_per_100g"
    t.decimal "custom_fats_per_100g"
    t.integer "user_id", null: false
    t.index ["food_id"], name: "index_entries_on_food_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "foods", force: :cascade do |t|
    t.string "name", null: false
    t.decimal "calories_per_100g", precision: 6, scale: 2, null: false
    t.decimal "carbs_per_100g", precision: 6, scale: 2, null: false
    t.decimal "protein_per_100g", precision: 6, scale: 2, null: false
    t.decimal "fats_per_100g", precision: 6, scale: 2, null: false
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_foods_on_category"
    t.index ["name"], name: "index_foods_on_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "entries", "foods"
  add_foreign_key "entries", "users"
end
