import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static values = { sidebarselector: String }
  connect() {
    console.log("Connected to Admin::Menu Controller")
    console.log(this.sidebarselectorValue || "No sidebarSelector value")
    this.sidebar = document.querySelector(this.sidebarselectorValue)
  }

  toggle(event) {
    event.preventDefault()
    this.sidebar.classList.toggle("-translate-x-full")
  }
}