import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "foodSelect",
    "customFields",
    "gramsInput",
    "macroPreview",
    "previewCalories",
    "previewCarbs",
    "previewProtein",
    "previewFats",
    "per100gInfo",
    "foodNameInput",
  ]

  connect() {
    this.updateMacros()
  }

  toggle() {
    this.customFieldsTarget.classList.toggle('d-none');
    this.foodSelectTarget.value = ''; // Clear food selection
    this.updateMacros(); // Hide preview when toggling
  }

  clearCustomFood() {
    this.foodNameInputTarget.value = '';
    this.updateMacros();
  }

  updateMacros() {
    const selectedOption = this.foodSelectTarget.options[this.foodSelectTarget.selectedIndex];
    const grams = parseFloat(this.gramsInputTarget.value) || 0;

    if (selectedOption && selectedOption.value && grams > 0) {
      const calories = parseFloat(selectedOption.dataset.calories) || 0;
      const carbs = parseFloat(selectedOption.dataset.carbs) || 0;
      const protein = parseFloat(selectedOption.dataset.protein) || 0;
      const fats = parseFloat(selectedOption.dataset.fats) || 0;

      const factor = grams / 100;

      // Update the preview elements with calculated values
      this.previewCaloriesTarget.textContent = Math.round(calories * factor);
      this.previewCarbsTarget.textContent = `${(carbs * factor).toFixed(1)}g`;
      this.previewProteinTarget.textContent = `${(protein * factor).toFixed(1)}g`;
      this.previewFatsTarget.textContent = `${(fats * factor).toFixed(1)}g`;

      this.per100gInfoTarget.innerHTML =
          `Per 100g: ${calories} cal, ${carbs}g carbs, ${protein}g protein, ${fats}g fats`;

      this.macroPreviewTarget.style.display = 'block';
    } else {
      // Hide the preview if no food is selected or grams are zero
      this.macroPreviewTarget.style.display = 'none';
    }
  }
}