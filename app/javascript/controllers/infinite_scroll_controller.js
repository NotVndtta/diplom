import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["entries", "pagination"]
  
  connect() {
    this.loading = false
  }

  loadMore(event) {
    event.preventDefault()
    
    if (this.loading) return
    
    this.loading = true
    const nextPageUrl = event.target.href

    fetch(nextPageUrl, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(response => response.text())
    .then(html => {
      Turbo.renderStreamMessage(html)
      this.loading = false
    })
  }
} 