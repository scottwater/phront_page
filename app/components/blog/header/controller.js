import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  // Define your controller actions and properties here
  static targets = ["mobileMenu"]
  connect() {
    this.ariaExpendedElements = this.element.querySelectorAll("[aria-expanded]")
  }

  toggleMenu() {
    this.mobileMenuTarget.classList.toggle("hidden")
    const hidden = this.mobileMenuTarget.classList.contains("hidden")
    this.ariaExpendedElements.forEach(element => {
      element.setAttribute("aria-expanded", !hidden)
    });

  }
}