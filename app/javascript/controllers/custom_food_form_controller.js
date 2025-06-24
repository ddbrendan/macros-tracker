import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "checkbox",

    // Form Sections
    "foodSelectContainer",
    "customFields",

    // Data Sources
    "foodSelect",
    "gramsInput",
    "foodNameInput",
    "customCaloriesInput",
    "customCarbsInput",
    "customProteinInput",
    "customFatsInput",

    // Macro Preview Elements
    "macroPreview",
    "previewCalories",
    "previewCarbs",
    "previewProtein",
    "previewFats",
    "per100gInfo",
  ]

  connect() {
    // Set the initial state of the form to match the checkbox on page load.
    this.toggle();
  }

  toggle() {
    // Read the state directly from the checkbox target.
    const isCustom = this.checkboxTarget.checked;

    // Set visibility based on the checkbox state
    this.customFieldsTarget.classList.toggle('d-none', !isCustom);
    this.foodSelectContainerTarget.classList.toggle('d-none', isCustom);

    // Clear the now-hidden inputs to ensure clean data submission
    if (isCustom) {
      this.foodSelectTarget.value = ''; // Clear food selection
    } else {
      this.foodNameInputTarget.value = ''; // Clear custom food name
      // Optionally clear all custom macro fields for a cleaner state
      this.customCaloriesInputTarget.value = '';
      this.customCarbsInputTarget.value = '';
      this.customProteinInputTarget.value = '';
      this.customFatsInputTarget.value = '';
    }
    
    // Re-calculate macros after any state change
    this.updateMacros();
  }

  updateMacros() {
    const grams = parseFloat(this.gramsInputTarget.value) || 0;
    const isCustom = this.checkboxTarget.checked; // <-- Always trust the checkbox
    let baseMacros = null;

    if (isCustom) {
      // Logic for custom food entry
      baseMacros = {
        calories: parseFloat(this.customCaloriesInputTarget.value) || 0,
        carbs: parseFloat(this.customCarbsInputTarget.value) || 0,
        protein: parseFloat(this.customProteinInputTarget.value) || 0,
        fats: parseFloat(this.customFatsInputTarget.value) || 0,
      };
    } else {
      // Logic for selected food from the database
      const selectedOption = this.foodSelectTarget.options[this.foodSelectTarget.selectedIndex];
      if (selectedOption && selectedOption.value) {
        baseMacros = {
          calories: parseFloat(selectedOption.dataset.calories) || 0,
          carbs: parseFloat(selectedOption.dataset.carbs) || 0,
          protein: parseFloat(selectedOption.dataset.protein) || 0,
          fats: parseFloat(selectedOption.dataset.fats) || 0,
        };
      }
    }

    if (baseMacros && grams > 0) {
      this._displayPreview(baseMacros, grams);
    } else {
      this._hidePreview();
    }
  }

  private
  
  _displayPreview(macros, grams) {
    const factor = grams / 100;

    this.previewCaloriesTarget.textContent = Math.round(macros.calories * factor);
    this.previewCarbsTarget.textContent = `${(macros.carbs * factor).toFixed(1)}g`;
    this.previewProteinTarget.textContent = `${(macros.protein * factor).toFixed(1)}g`;
    this.previewFatsTarget.textContent = `${(macros.fats * factor).toFixed(1)}g`;

    this.per100gInfoTarget.innerHTML =
      `Per 100g: ${macros.calories} cal, ${macros.carbs}g carbs, ${macros.protein}g protein, ${macros.fats}g fats`;

    this.macroPreviewTarget.style.display = 'block';
  }

  _hidePreview() {
    this.macroPreviewTarget.style.display = 'none';
  }
}