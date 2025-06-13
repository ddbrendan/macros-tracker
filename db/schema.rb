ActiveRecord::Schema[8.0].define(version: 2025_06_13_082348) do
  create_table "entries", force: :cascade do |t|
    t.string "food_name"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "food_id"
    t.decimal "grams", precision: 6, scale: 1
    t.index ["food_id"], name: "index_entries_on_food_id"
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

  add_foreign_key "entries", "foods"
end
