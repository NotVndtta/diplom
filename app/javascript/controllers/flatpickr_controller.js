import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr"
import { Russian } from "flatpickr/dist/l10n/ru.js"

export default class extends Controller {
  connect() {
    this.fp = flatpickr(this.element, {
      dateFormat: "Y-m-d",
      locale: Russian,
      disableMobile: false,
      allowInput: true,
      minDate: "today",
      defaultDate: "today"
    })
  }

  disconnect() {
    this.fp.destroy()
  }
} 