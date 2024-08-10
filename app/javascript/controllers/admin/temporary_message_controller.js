import { Controller } from "@hotwired/stimulus"
import { useTransition } from "stimulus-use"

export default class extends Controller {
  static values = {
    delay: { type: Number, default: 6000 }
  }
  connect() {
    console.log("Temporary Message Controller Connected")
    useTransition(this, {
      element: this.element,
      enterActive: 'transition duration-1000',
      enterFrom: 'opacity-0 translate-x-6',
      enterTo: 'opacity-100 translate-x-0',
      leaveActive: 'transition duration-1000',
      leaveFrom: 'opacity-100 translate-x-0',
      leaveTo: 'opacity-0 translate-x-6',
    })

    // Set a timeout to hide the element after 5 seconds
    this.timeout = setTimeout(() => {
      this.hide()
    }, this.delayValue)

    this.enter();
  }

  async hide() {
    this.timeout && clearTimeout(this.timeout)
    await this.leave()
    this.element.remove()
  }


}