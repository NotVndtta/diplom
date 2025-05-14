import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "star", "input" ]

  connect() {
    this.rating = 0
    this.updateStars()
  }

  setRating(event) {
    const star = event.currentTarget
    this.rating = parseInt(star.dataset.rating)
    this.inputTarget.value = this.rating
    this.updateStars()
  }

  updateStars() {
    this.starTargets.forEach((star, index) => {
      const rating = parseInt(star.dataset.rating)
      if (rating <= this.rating) {
        star.classList.remove('text-gray-300')
        star.classList.add('text-yellow-400')
      } else {
        star.classList.remove('text-yellow-400')
        star.classList.add('text-gray-300')
      }
    })
  }

  hover(event) {
    const rating = parseInt(event.currentTarget.dataset.rating)
    this.starTargets.forEach((star, index) => {
      const starRating = parseInt(star.dataset.rating)
      if (starRating <= rating) {
        star.classList.remove('text-gray-300')
        star.classList.add('text-yellow-400')
      } else {
        star.classList.remove('text-yellow-400')
        star.classList.add('text-gray-300')
      }
    })
  }

  resetStars() {
    this.updateStars()
  }
} 