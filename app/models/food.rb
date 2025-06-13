class Food < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :calories_per_100g, :carbs_per_100g, :protein_per_100g, :fats_per_100g, 
              presence: true, numericality: { greater_than_or_equal_to: 0 }
    
    def calculate_macros(grams)
      factor = grams / 100.0
      {
        calories: (calories_per_100g * factor).round(1),
        carbs: (carbs_per_100g * factor).round(1),
        protein: (protein_per_100g * factor).round(1),
        fats: (fats_per_100g * factor).round(1)
      }
    end
    
    scope :search_by_name, ->(query) { where("LOWER(name) LIKE ?", "%#{query.downcase}%") }
  end