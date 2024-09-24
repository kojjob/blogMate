import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.dismiss = this.dismiss.bind(this)
    setTimeout(this.dismiss, 5000)
  }

  dismiss() {
    this.element.classList.add('opacity-0', 'transition-opacity', 'duration-500')
    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}