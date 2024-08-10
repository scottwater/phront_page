import { Controller } from "@hotwired/stimulus"
import { get } from '@rails/request.js'
export default class extends Controller {
  static values = {
    modelType: String,
    modelId: String
  }
  static targets = ["revisions", "spinner"]

  initialize() {
    this.bindedOnDrawerShown = this.onDrawerShown.bind(this)
  }

  connect() {
    console.log("Revisions Controller Connecting")
    document.addEventListener('drawer:shown', this.bindedOnDrawerShown)
  }

  disconnect() {
    document.removeEventListener('drawer:shown', this.bindedOnDrawerShown)
  }

  // Flowbite's drawers support only a single callback. This controller now depends on an event drawer:shown
  // that is triggered by the drawer controller.
  onDrawerShown(event) {
    if (event.detail.drawerId === this.element.id) {
    console.log("Revisions Controller Connected")
    this.fetchRevisions()
    } else {
      console.log("Not the drawer we are looking for says Revisions")
    }
  }

  async fetchRevisions() {
    this.revisionsTarget.innerHTML = ""
    const url = `/admin/revisions/${this.modelTypeValue}/${this.modelIdValue}`
    const response = await get(url, {
      responseKind: "turbo-stream"
    })
    if (response.ok) {
      this.spinnerTarget.classList.add("hidden")
    } else {
      try {
        const errorMessage = await response.text
        this.spinnerTarget.classList.add("hidden")
        this.revisionsTarget.innerHTML = `<div class="bg-red-50 p-4 text-red-500">
          <h1 class="font-bold text-4xl">Revisions Failed to Load</h1>
          <p>${errorMessage}</p>
        </div>`
      } catch (e) {
        this.spinnerTarget.classList.add("hidden")
        this.revisionsTarget.innerHTML = `<div class="bg-red-50 p-4 text-red-500">
            <h1 class="font-bold text-4xl">Revisions Failed to Load</h1>
            <p>Status: ${response.statusCode}</p>
            <p>Unable to read error details: ${e}</p>
        </div>`

      }
    }
  }
}