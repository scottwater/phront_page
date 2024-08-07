
import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static values = { delay: Number }

  connect() {
    console.log("Connected to Admin::PopupCloser Controller")
    console.log(this.delayValue)
    setTimeout(() => {
      window.close()
    }, this.delayValue)
  }
}