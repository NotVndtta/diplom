import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (window.innerWidth >= 640) {
      document.body.classList.add('overflow-hidden')
    }
  }

  disconnect() {
    document.body.classList.remove('overflow-hidden')
  }
} 