import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'
export default class extends Controller {
  hasPendingChanges = false
  static values = {
    url: String,
    formId: String,
    minimalLength: { type: Number, default: 30 },
    delay: { type: Number, default: 2 * 60000 }
  }
  static targets = ["form", "minimalLegthField"]

  initialize() {
    this.boundTrackChanges = this.trackChanges.bind(this)
  }

  connect() {
    document.addEventListener("keydown", this.handleKeyDown)
    this.element.addEventListener("input", this.boundTrackChanges)
    this.timeout = setInterval(() => {
      if (this.hasPendingChanges) {
        this.sync()
      }
    }, this.delayValue);
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeyDown)
    this.element.removeEventListener("input", this.boundTrackChanges)
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
  }

  trackChanges() {
    this.hasPendingChanges = true
  }

  hasFieldsWithoutMinimalLength() {
    return this.minimalLegthFieldTargets.some(field =>
      field.value.length < this.minimalLengthValue
    )
  }

  handleKeyDown = (event) => {
    if (event.ctrlKey && event.key === "s") {
      this.sync(true)
   }
 }

  async sync(skipChecks = false) {
    console.log(`Syncing Changes ${skipChecks}`)
    this.hasPendingChanges = false
    const form = new FormData(this.formTarget)
    if (!skipChecks && this.hasFieldsWithoutMinimalLength()) {
      return
    }

    const response = await post(this.urlValue, {
      body: form,
      responseKind: "turbo-stream"
    })
    if (response.ok)  {
      const event = new CustomEvent('revision:saved')
      document.dispatchEvent(event)
    } else {
      try {
        const errorMessage = await response.text
        console.error(`Preview Failed: ${errorMessage}`)
      } catch (e) {
        console.error(`Preview Failed: ${response.statusCode} - Unable to read error details: ${e}`)
      }
    }
  }
}