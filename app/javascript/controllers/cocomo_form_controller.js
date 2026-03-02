import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "klocInput"]

  connect() {
    this._debounceTimer = null
  }

  submit() {
    clearTimeout(this._debounceTimer)
    this._debounceTimer = setTimeout(() => {
      this.formTarget.requestSubmit()
    }, 200)
  }

  disconnect() {
    clearTimeout(this._debounceTimer)
  }
}
