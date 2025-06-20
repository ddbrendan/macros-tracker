# in app/models/entry.rb

class Entry < ApplicationRecord
  # This creates a "virtual attribute" for the form checkbox, it's not saved to the DB
  attr_accessor :custom

  belongs_to :food, optional: true

  validates :date, presence: true
  validates :grams, presence: true, numericality: { greater_than: 0 }
  validate :food_or_custom_food_is_present

  validates :food_name, presence: true, if: :custom_entry?
  validates :custom_calories_per_100g, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: :custom_entry?
  validates :custom_carbs_per_100g, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: :custom_entry?
  validates :custom_protein_per_100g, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: :custom_entry?
  validates :custom_fats_per_100g, presence: true, numericality: { greater_than_or_equal_to: 0 }, if: :custom_entry?

  # Returns true if the food_id is blank, indicating a custom entry
  def custom_entry?
    food_id.blank?
  end

  # Returns the correct name to show in the view
  def display_name
    custom_entry? ? food_name : food&.name
  end

  # These four methods are what your view file calls.
  # They get their data from the `calculated_macros` hash.
  def calories
    calculated_macros[:calories].to_f
  end

  def carbs
    calculated_macros[:carbs].to_f
  end

  def protein
    calculated_macros[:protein].to_f
  end

  def fats
    calculated_macros[:fats].to_f
  end


  private

  # This is the main calculation method. It checks if the entry is custom
  # and returns a hash of macros. The result is "memoized" (cached) in an
  # instance variable so it only needs to be calculated once per request.
  def calculated_macros
    @calculated_macros ||= if custom_entry?
                             calculate_custom_macros
                           else
                             food&.calculate_macros(grams) || {}
                           end
  end

  # Calculates macros for a custom food entry.
  def calculate_custom_macros
    factor = grams / 100.0
    {
      calories: (custom_calories_per_100g || 0 * factor),
      carbs: (custom_carbs_per_100g || 0 * factor),
      protein: (custom_protein_per_100g || 0 * factor),
      fats: (custom_fats_per_100g || 0 * factor)
    }
  end

  # A validation to ensure that the user has either selected a food or entered a custom food name.
  def food_or_custom_food_is_present
    if food_id.blank? && food_name.blank?
      errors.add(:base, "Please either select a food or enter a custom food name.")
    end
  end
end