import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "mobileMenu"]

  connect() {
    // This will log to the console when the controller connects
    console.log("Dropdown controller connected")
  }

  toggle(event) {
    event.preventDefault()
    this.menuTarget.classList.toggle("hidden")
  }

  toggleMobile(event) {
    event.preventDefault()
    this.mobileMenuTarget.classList.toggle("hidden")
  }

  hide(event) {
    if (!this.element.contains(event.target)) {
      this.menuTarget.classList.add("hidden")
      this.mobileMenuTarget.classList.add("hidden")
    }
  }

  disconnect() {
    document.removeEventListener("click", this.hide.bind(this))
  }
}