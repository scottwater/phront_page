import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'
export default class extends Controller {
  static values = {
    url: String,
    formId: String
  }
  static targets = ["preview", "spinner"]

  connect() {
    this.bindedOnDrawerShown = this.onDrawerShown.bind(this)
    document.addEventListener('drawer:shown', this.bindedOnDrawerShown)
  }

  disconnect() {
    document.removeEventListener('drawer:shown', this.bindedOnDrawerShown)
  }

  // Flowbite's drawers support only a single callback. This controller now depends on an event drawer:shown
  // that is triggered by the drawer controller.
  onDrawerShown() {
    this.preview()
  }

  async preview() {
    this.previewTarget.innerHTML = ""
    const formElement = document.getElementById(this.formIdValue)
    const form = new FormData(formElement)
    const response = await post(this.urlValue, {
      body: form,
      responseKind: "turbo-stream"
    })
    if (response.ok) {
      this.spinnerTarget.classList.add("hidden")
    } else {
      try {
        const errorMessage = await response.text
        this.spinnerTarget.classList.add("hidden")
        this.previewTarget.innerHTML = `<div class="bg-red-50 p-4 text-red-500">
          <h1 class="font-bold text-4xl">Preview Failed</h1>
          <p>${errorMessage}</p>
        </div>`
      } catch (e) {
        this.spinnerTarget.classList.add("hidden")
        this.previewTarget.innerHTML = `<div class="bg-red-50 p-4 text-red-500">
            <h1 class="font-bold text-4xl">Preview Failed</h1>
            <p>Status: ${response.statusCode}</p>
            <p>Unable to read error details: ${e}</p>
        </div>`

      }
    }
  }
}