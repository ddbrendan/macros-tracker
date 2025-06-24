Food.destroy_all

fruits = [
  { name: "Apple", calories_per_100g: 52, carbs_per_100g: 14, protein_per_100g: 0.3, fats_per_100g: 0.2, category: "Fruits" },
  { name: "Banana", calories_per_100g: 89, carbs_per_100g: 23, protein_per_100g: 1.1, fats_per_100g: 0.3, category: "Fruits" },
  { name: "Orange", calories_per_100g: 47, carbs_per_100g: 12, protein_per_100g: 0.9, fats_per_100g: 0.1, category: "Fruits" },
  { name: "Strawberries", calories_per_100g: 32, carbs_per_100g: 7.7, protein_per_100g: 0.7, fats_per_100g: 0.3, category: "Fruits" },
  { name: "Blueberries", calories_per_100g: 57, carbs_per_100g: 14.5, protein_per_100g: 0.7, fats_per_100g: 0.3, category: "Fruits" },
  { name: "Grapes", calories_per_100g: 69, carbs_per_100g: 18, protein_per_100g: 0.7, fats_per_100g: 0.2, category: "Fruits" },
  { name: "Watermelon", calories_per_100g: 30, carbs_per_100g: 7.6, protein_per_100g: 0.6, fats_per_100g: 0.2, category: "Fruits" }
]

vegetables = [
  { name: "Broccoli", calories_per_100g: 34, carbs_per_100g: 6.6, protein_per_100g: 2.8, fats_per_100g: 0.4, category: "Vegetables" },
  { name: "Spinach", calories_per_100g: 23, carbs_per_100g: 3.6, protein_per_100g: 2.9, fats_per_100g: 0.4, category: "Vegetables" },
  { name: "Tomato", calories_per_100g: 18, carbs_per_100g: 3.9, protein_per_100g: 0.9, fats_per_100g: 0.2, category: "Vegetables" },
  { name: "Carrot", calories_per_100g: 41, carbs_per_100g: 9.6, protein_per_100g: 0.9, fats_per_100g: 0.2, category: "Vegetables" },
  { name: "Cucumber", calories_per_100g: 16, carbs_per_100g: 3.6, protein_per_100g: 0.7, fats_per_100g: 0.1, category: "Vegetables" },
  { name: "Bell Pepper", calories_per_100g: 31, carbs_per_100g: 6, protein_per_100g: 1, fats_per_100g: 0.3, category: "Vegetables" },
  { name: "Lettuce", calories_per_100g: 15, carbs_per_100g: 2.9, protein_per_100g: 1.4, fats_per_100g: 0.2, category: "Vegetables" }
]

proteins = [
  { name: "Chicken Breast", calories_per_100g: 165, carbs_per_100g: 0, protein_per_100g: 31, fats_per_100g: 3.6, category: "Proteins" },
  { name: "Salmon", calories_per_100g: 208, carbs_per_100g: 0, protein_per_100g: 20, fats_per_100g: 13, category: "Proteins" },
  { name: "Eggs", calories_per_100g: 155, carbs_per_100g: 1.1, protein_per_100g: 13, fats_per_100g: 11, category: "Proteins" },
  { name: "Greek Yogurt", calories_per_100g: 59, carbs_per_100g: 3.6, protein_per_100g: 10, fats_per_100g: 0.4, category: "Proteins" },
  { name: "Tofu", calories_per_100g: 76, carbs_per_100g: 1.9, protein_per_100g: 8, fats_per_100g: 4.8, category: "Proteins" },
  { name: "Tuna", calories_per_100g: 116, carbs_per_100g: 0, protein_per_100g: 26, fats_per_100g: 1, category: "Proteins" },
  { name: "Cottage Cheese", calories_per_100g: 98, carbs_per_100g: 3.4, protein_per_100g: 11, fats_per_100g: 4.3, category: "Proteins" }
]


grains = [
  { name: "Brown Rice", calories_per_100g: 112, carbs_per_100g: 24, protein_per_100g: 2.3, fats_per_100g: 0.8, category: "Grains" },
  { name: "White Rice", calories_per_100g: 130, carbs_per_100g: 28, protein_per_100g: 2.7, fats_per_100g: 0.3, category: "Grains" },
  { name: "Oatmeal", calories_per_100g: 71, carbs_per_100g: 12, protein_per_100g: 2.5, fats_per_100g: 1.5, category: "Grains" },
  { name: "Whole Wheat Bread", calories_per_100g: 252, carbs_per_100g: 43, protein_per_100g: 13, fats_per_100g: 3.5, category: "Grains" },
  { name: "Pasta", calories_per_100g: 131, carbs_per_100g: 25, protein_per_100g: 5, fats_per_100g: 1.1, category: "Grains" },
  { name: "Quinoa", calories_per_100g: 120, carbs_per_100g: 21, protein_per_100g: 4.4, fats_per_100g: 1.9, category: "Grains" }
]


dairy = [
  { name: "Milk (2%)", calories_per_100g: 50, carbs_per_100g: 4.8, protein_per_100g: 3.3, fats_per_100g: 2, category: "Dairy" },
  { name: "Cheddar Cheese", calories_per_100g: 403, carbs_per_100g: 1.3, protein_per_100g: 25, fats_per_100g: 33, category: "Dairy" },
  { name: "Butter", calories_per_100g: 717, carbs_per_100g: 0.1, protein_per_100g: 0.9, fats_per_100g: 81, category: "Dairy" },
  { name: "Yogurt", calories_per_100g: 61, carbs_per_100g: 4.7, protein_per_100g: 3.5, fats_per_100g: 3.3, category: "Dairy" }
]


nuts_seeds = [
  { name: "Almonds", calories_per_100g: 579, carbs_per_100g: 22, protein_per_100g: 21, fats_per_100g: 50, category: "Nuts & Seeds" },
  { name: "Peanut Butter", calories_per_100g: 588, carbs_per_100g: 20, protein_per_100g: 25, fats_per_100g: 50, category: "Nuts & Seeds" },
  { name: "Walnuts", calories_per_100g: 654, carbs_per_100g: 14, protein_per_100g: 15, fats_per_100g: 65, category: "Nuts & Seeds" },
  { name: "Chia Seeds", calories_per_100g: 486, carbs_per_100g: 42, protein_per_100g: 17, fats_per_100g: 31, category: "Nuts & Seeds" }
]


other = [
  { name: "Olive Oil", calories_per_100g: 884, carbs_per_100g: 0, protein_per_100g: 0, fats_per_100g: 100, category: "Oils & Fats" },
  { name: "Avocado", calories_per_100g: 160, carbs_per_100g: 9, protein_per_100g: 2, fats_per_100g: 15, category: "Fruits" },
  { name: "Dark Chocolate (70%)", calories_per_100g: 598, carbs_per_100g: 46, protein_per_100g: 7.8, fats_per_100g: 43, category: "Sweets" },
  { name: "Honey", calories_per_100g: 304, carbs_per_100g: 82, protein_per_100g: 0.3, fats_per_100g: 0, category: "Sweets" },
  { name: "Sugar", calories_per_100g: 387, carbs_per_100g: 100, protein_per_100g: 0, fats_per_100g: 0, category: "Sweets" }
]


all_foods = fruits + vegetables + proteins + grains + dairy + nuts_seeds + other

all_foods.each do |food_data|
  Food.create!(food_data)
end

puts "Created #{Food.count} foods in the database!"
