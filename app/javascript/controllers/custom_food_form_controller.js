import { Controller } from "@hotwired/stimulus"

console.log("custom_food_form_controller.js file loaded")

export default class extends Controller {
  static targets = [ "foodSelect", "customFields" ]

  initialize() {
    console.log("CustomFoodForm controller initialized")
  }

  connect() {
    console.log("CustomFoodForm controller connected!")
    console.log("Element:", this.element)
    console.log("Has foodSelect target?", this.hasFoodSelectTarget)
    console.log("Has customFields target?", this.hasCustomFieldsTarget)
  }

  disconnect() {
    console.log("CustomFoodForm controller disconnected")
  }

  toggle(event) {
    console.log("Toggle called!", event)
    const isChecked = event.currentTarget.checked;

    if (isChecked) {
      this.foodSelectTarget.classList.add("d-none");
      this.customFieldsTarget.classList.remove("d-none");
    } else {
      this.foodSelectTarget.classList.remove("d-none");
      this.customFieldsTarget.classList.add("d-none");
    }
  }
}