import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove"
export default class extends Controller {
  connect() {
    console.log("Connected to Admin::Sidebar Controller")
  }
}