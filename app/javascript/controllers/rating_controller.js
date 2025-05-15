import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "star", "input" ]

  connect() {
    this.resetStars()
  }

  setRating(event) {
    const rating = parseInt(event.currentTarget.dataset.rating)
    this.inputTarget.value = rating
    this.updateStars(rating)
  }

  hover(event) {
    const rating = parseInt(event.currentTarget.dataset.rating)
    this.updateStars(rating)
  }

  resetStars() {
    const currentRating = parseInt(this.inputTarget.value) || 0
    this.updateStars(currentRating)
  }

  updateStars(rating) {
    this.starTargets.forEach((star, index) => {
      const starRating = parseInt(star.dataset.rating)
      const path = star.querySelector('path')
      
      if (starRating <= rating) {
        path.classList.remove('text-gray-300')
        path.classList.add('text-yellow-400')
      } else {
        path.classList.remove('text-yellow-400')
        path.classList.add('text-gray-300')
      }
    })
  }
} 