import { Controller } from "@hotwired/stimulus"
import { post } from '@rails/request.js'
export default class extends Controller {
  static values = {
    url: String,
    formId: String
  }
  static targets = ["button", "preview", "spinner"]

  connect() {
    document.addEventListener("turbo:load", () => this.initializeDrawer())
    this.initializeDrawer()
  }

  initializeDrawer() {
    if (!this.element) return
    const observer = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        if (mutation.type === 'attributes' && mutation.attributeName === 'aria-hidden') {
          this.onDrawerInitialized(this.element)
          observer.disconnect()
        }
      })
    })

    observer.observe(this.element, { attributes: true })
  }

  onDrawerInitialized(drawerElement) {
    console.log("Drawer initialized")
    this.drawer = FlowbiteInstances.getInstance('Drawer', drawerElement.id)
    if (this.drawer) {
      this.drawer.updateOnShow(() => {
        this.spinnerTarget.classList.remove("hidden")
        console.log("Showing drawer")
        this.preview()
      })
    }
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
    }
  }
}