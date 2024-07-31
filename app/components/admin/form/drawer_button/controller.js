
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { position: String, drawerId: String }
  connect() {
    document.addEventListener("keydown", this.handleKeyDown)
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeyDown)
  }

  handleKeyDown = (event) => {
     if (event.ctrlKey && event.key === "o") {
      if (this.isElementVisible(`button[data-drawer-hide=drawer-${this.drawerIdValue}]`)) {
        document.querySelector(`button[data-drawer-hide=drawer-${this.drawerIdValue}]`).click()
      }
      else {
        this.element.click()
      }
    }
  }

  isElementVisible(selector) {
    const element = document.querySelector(selector);

    if (!element) {
      return false; // Element doesn't exist
    }

    // Check if the element has display: none
    if (window.getComputedStyle(element).display === 'none') {
      return false;
    }

    // Check if the element has visibility: hidden
    if (window.getComputedStyle(element).visibility === 'hidden') {
      return false;
    }

    // Check if the element is within the viewport
    const rect = element.getBoundingClientRect();
    return (
      rect.top >= 0 &&
      rect.left >= 0 &&
      rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
      rect.right <= (window.innerWidth || document.documentElement.clientWidth)
    );
  }
}

