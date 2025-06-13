class Entry < ApplicationRecord
    belongs_to :food, optional: true
    
    validates :date, presence: true
    validates :grams, presence: true, numericality: { greater_than: 0 }
    
    validate :food_presence
    
    def calculate_macros
      return {} unless food
      
      food.calculate_macros(grams)
    end
    
    def calories
      calculate_macros[:calories] || 0
    end
    
    def carbs
      calculate_macros[:carbs] || 0
    end
    
    def protein
      calculate_macros[:protein] || 0
    end
    
    def fats
      calculate_macros[:fats] || 0
    end
    
    def display_name
      food&.name || food_name
    end
    
    private
    
    def food_presence
      if food_id.blank? && food_name.blank?
        errors.add(:base, "Either select a food from the database or enter a custom food name")
      end
    end
  end