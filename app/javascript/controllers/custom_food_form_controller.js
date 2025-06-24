import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "checkbox",
    "foodSelectContainer",
    "customFields",
    "foodSearchInput",
    "foodOptions",
    "foodIdInput",
    "gramsInput",
    "foodNameInput",
    "customCaloriesInput",
    "customCarbsInput",
    "customProteinInput",
    "customFatsInput",
    "macroPreview",
    "previewCalories",
    "previewCarbs",
    "previewProtein",
    "previewFats",
    "per100gInfo",
  ]

  connect() {
    this.toggle();
    // Debounce the search function to avoid sending too many requests while typing
    this.performSearch = this.debounce(this.performSearch, 300);
  }

  // This is the main action called when the user types in the search box.
  search() {
    this.updateSelectedFood();
    this.performSearch();
    this.updateMacros();
  }

  // Called when the "Custom Food" checkbox is toggled.
  toggle() {
    const isCustom = this.checkboxTarget.checked;

    this.customFieldsTarget.classList.toggle('d-none', !isCustom);
    this.foodSelectContainerTarget.classList.toggle('d-none', isCustom);

    if (isCustom) {
      // Clear food search and ID when switching to custom
      this.foodSearchInputTarget.value = '';
      if (this.hasFoodIdInputTarget) this.foodIdInputTarget.value = '';
    } else {
      // Clear custom fields when switching back to database search
      this.foodNameInputTarget.value = '';
      this.customCaloriesInputTarget.value = '';
      this.customCarbsInputTarget.value = '';
      this.customProteinInputTarget.value = '';
      this.customFatsInputTarget.value = '';
    }
    
    this.updateMacros();
  }

  // Checks if the current input value matches a food in the datalist and updates the hidden ID field.
  updateSelectedFood() {
    const inputValue = this.foodSearchInputTarget.value;
    const selectedOption = Array.from(this.foodOptionsTarget.options).find(opt => opt.value === inputValue);

    this.foodIdInputTarget.value = selectedOption ? selectedOption.dataset.foodId : '';
  }
  
  // Fetches food data from the server based on the user's query.
  performSearch() {
    const query = this.foodSearchInputTarget.value;

    if (query.length < 2) {
      this.foodOptionsTarget.innerHTML = '';
      return;
    }

    fetch(`/foods?search=${query}&format=json`, {
      headers: { "Accept": "application/json" }
    })
    .then(response => response.json())
    .then(foods => {
      this.foodOptionsTarget.innerHTML = '';
      foods.forEach(food => {
        const option = document.createElement('option');
        option.value = food.name;
        // Store all necessary data on the option element for later use
        option.dataset.foodId = food.id;
        option.dataset.calories = food.calories_per_100g;
        option.dataset.carbs = food.carbs_per_100g;
        option.dataset.protein = food.protein_per_100g;
        option.dataset.fats = food.fats_per_100g;
        this.foodOptionsTarget.appendChild(option);
      });
    });
  }

  // Calculates and displays the macros based on the current form state.
  updateMacros() {
    const grams = parseFloat(this.gramsInputTarget.value) || 0;
    const isCustom = this.checkboxTarget.checked;
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
      // **FIXED LOGIC**: Get data from the search datalist, not the old select element.
      const inputValue = this.foodSearchInputTarget.value;
      const selectedOption = Array.from(this.foodOptionsTarget.options).find(opt => opt.value === inputValue);
      
      if (selectedOption) {
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

  // --- Helper and Private Methods ---

  // Simple debounce function to delay execution and prevent excessive server requests.
  debounce(func, wait) {
    let timeout;
    return function(...args) {
      const context = this;
      clearTimeout(timeout);
      timeout = setTimeout(() => func.apply(context, args), wait);
    };
  }

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