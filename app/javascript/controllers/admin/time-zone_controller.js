import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["timezone"];
  connect() {
    this.setTimeZone()
  }

  setTimeZone() {
    this.timezoneTarget.value = Intl.DateTimeFormat().resolvedOptions().timeZone;
  }
}