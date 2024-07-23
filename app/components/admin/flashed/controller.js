import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    autoRemove: { type: Boolean, default: false }
  }

  connect() {
    console.log('Connected to remove controller')
    if (this.autoRemoveValue) {
      this.timeout = setTimeout(() => {
        this.removeElement();
      }, 5000);
    }
  }

  disconnect() {
    if (this.timeout) {
      clearTimeout(this.timeout);
    }
  }

  remove() {
    this.removeElement();
  }

  removeElement() {
    this.element.remove();
  }
}
