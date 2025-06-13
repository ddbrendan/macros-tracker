class CreateFoods < ActiveRecord::Migration[8.0]
  def change
    create_table :foods do |t|
      t.string :name, null: false
      t.decimal :calories_per_100g, precision: 6, scale: 2, null: false
      t.decimal :carbs_per_100g, precision: 6, scale: 2, null: false
      t.decimal :protein_per_100g, precision: 6, scale: 2, null: false
      t.decimal :fats_per_100g, precision: 6, scale: 2, null: false
      t.string :category
      
      t.timestamps
    end
    
    add_index :foods, :name
    add_index :foods, :category
  end
end