class UpdateEntriesForMacros < ActiveRecord::Migration[8.0]
  def change
    add_reference :entries, :food, foreign_key: true
    
    add_column :entries, :grams, :decimal, precision: 6, scale: 1
    
    remove_column :entries, :calories, :integer
    
    change_column_null :entries, :food_name, true
  end
end