import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["nav", "flash", "content"]

  connect() {
    console.log("Auth controller connected")
  }

  updateNav(event) {
    this.navTarget.innerHTML = event.detail.content
  }

  updateFlash(event) {
    this.flashTarget.innerHTML = event.detail.content
  }

  updateContent(event) {
    this.contentTarget.innerHTML = event.detail.content
  }
}
