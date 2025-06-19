class AddCustomMacrosToEntries < ActiveRecord::Migration[8.0]
  def change
    add_column :entries, :custom_calories_per_100g, :decimal
    add_column :entries, :custom_carbs_per_100g, :decimal
    add_column :entries, :custom_protein_per_100g, :decimal
    add_column :entries, :custom_fats_per_100g, :decimal
  end
end
