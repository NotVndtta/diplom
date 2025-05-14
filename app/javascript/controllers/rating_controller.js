import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "star", "input" ]

  connect() {
    this.resetStars()
  }

  setRating(event) {
    const rating = event.currentTarget.dataset.rating
    this.inputTarget.value = rating
    this.updateStars(rating)
  }

  hover(event) {
    const rating = event.currentTarget.dataset.rating
    this.updateStars(rating)
  }

  resetStars() {
    const currentRating = this.inputTarget.value
    this.updateStars(currentRating)
  }

  updateStars(rating) {
    this.starTargets.forEach((star, index) => {
      const path = star.querySelector('path')
      if (index < rating) {
        path.classList.remove('text-gray-300')
        path.classList.add('text-yellow-400')
      } else {
        path.classList.remove('text-yellow-400')
        path.classList.add('text-gray-300')
      }
    })
  }
} 