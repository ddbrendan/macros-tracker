// app/javascript/controllers/custom_food_form_controller.js

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
    this.performSearch = this.debounce(this.performSearch, 300);
    this.selectedFoodData = null; // Property to hold the selected food's attributes

    // Add a global click listener to hide the dropdown when clicking outside
    this.boundHideDropdown = this.hideDropdown.bind(this);
    document.addEventListener('click', this.boundHideDropdown);
  }

  disconnect() {
    // Clean up the event listener when the controller is disconnected
    document.removeEventListener('click', this.boundHideDropdown);
  }

  // Hide the dropdown unless the click was inside the controller's element
  hideDropdown(event) {
    if (event && this.element.contains(event.target)) {
      return;
    }
    if (this.hasFoodOptionsTarget) {
      this.foodOptionsTarget.classList.remove('active');
    }
  }

  // The main action called when the user types in the search box.
  search() {
    // When a user types, we assume they are searching for a new food,
    // so we clear the previously selected ID and data.
    this.foodIdInputTarget.value = '';
    this.selectedFoodData = null;
    this.updateMacros(); // Clear the preview
    this.performSearch();
  }

  // Called when a user clicks a food item in the dropdown.
  selectFood(event) {
    event.preventDefault(); // Prevent any default browser action

    const selectedItem = event.currentTarget;
    this.foodSearchInputTarget.value = selectedItem.dataset.foodName;
    this.foodIdInputTarget.value = selectedItem.dataset.foodId;

    // Store the selected food's attributes directly on the controller
    this.selectedFoodData = {
      calories: parseFloat(selectedItem.dataset.calories),
      carbs: parseFloat(selectedItem.dataset.carbs),
      protein: parseFloat(selectedItem.dataset.protein),
      fats: parseFloat(selectedItem.dataset.fats),
    };

    // Manually hide the dropdown and update macros
    this.foodOptionsTarget.classList.remove('active');
    this.updateMacros();
  }

  // Fetches food data and builds the dropdown with divs.
  performSearch() {
    const query = this.foodSearchInputTarget.value;

    if (query.length < 2) {
      this.foodOptionsTarget.classList.remove('active');
      this.foodOptionsTarget.innerHTML = '';
      return;
    }

    fetch(`/foods?search=${query}&format=json`, {
      headers: { "Accept": "application/json" }
    })
    .then(response => response.json())
    .then(foods => {
      this.foodOptionsTarget.innerHTML = ''; // Clear previous results
      if (foods.length > 0) {
        foods.forEach(food => {
          const item = document.createElement('div');
          item.classList.add('dropdown-item');
          // Set data attributes for all necessary food info
          item.dataset.action = 'click->custom-food-form#selectFood';
          item.dataset.foodId = food.id;
          item.dataset.foodName = food.name;
          item.dataset.calories = food.calories_per_100g;
          item.dataset.carbs = food.carbs_per_100g;
          item.dataset.protein = food.protein_per_100g;
          item.dataset.fats = food.fats_per_100g;
          item.textContent = food.name;

          item.innerHTML = `
          <div class="item-content">
            <div class="item-name">${food.name}</div>
            <div class="item-macros">
              Kcal: ${food.calories_per_100g} | P: ${food.protein_per_100g}g | C: ${food.carbs_per_100g}g | F: ${food.fats_per_100g}g
            </div>
          </div>
        `;
          this.foodOptionsTarget.appendChild(item);
        });
        this.foodOptionsTarget.classList.add('active'); // Show the dropdown
      } else {
        this.foodOptionsTarget.classList.remove('active'); // Hide if no results
      }
    });
  }

  updateMacros() {
    const grams = parseFloat(this.gramsInputTarget.value) || 0;
    const isCustom = this.checkboxTarget.checked;
    let baseMacros = null;

    if (isCustom) {
      baseMacros = {
        calories: parseFloat(this.customCaloriesInputTarget.value) || 0,
        carbs: parseFloat(this.customCarbsInputTarget.value) || 0,
        protein: parseFloat(this.customProteinInputTarget.value) || 0,
        fats: parseFloat(this.customFatsInputTarget.value) || 0,
      };
    } else {
      if (this.selectedFoodData) {
        baseMacros = this.selectedFoodData;
      }
    }

    if (baseMacros && grams > 0) {
      this._displayPreview(baseMacros, grams);
    } else {
      this._hidePreview();
    }
  }

  toggle() {
    const isCustom = this.checkboxTarget.checked;
    this.customFieldsTarget.classList.toggle('d-none', !isCustom);
    this.foodSelectContainerTarget.classList.toggle('d-none', isCustom);
    if (isCustom) {
      this.foodSearchInputTarget.value = '';
      if (this.hasFoodIdInputTarget) this.foodIdInputTarget.value = '';
      this.selectedFoodData = null;
    } else {
      this.foodNameInputTarget.value = '';
      this.customCaloriesInputTarget.value = '';
      this.customCarbsInputTarget.value = '';
      this.customProteinInputTarget.value = '';
      this.customFatsInputTarget.value = '';
    }
    this.updateMacros();
  }

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