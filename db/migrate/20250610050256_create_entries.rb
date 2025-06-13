class CreateEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :entries do |t|
      t.string :food_name
      t.integer :calories
      t.date :date

      t.timestamps
    end
  end
end
