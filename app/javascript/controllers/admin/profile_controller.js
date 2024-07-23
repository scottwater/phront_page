import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "message"]
  static values = { timezones: String}

  connect() {
    this.timeZoneMapping = JSON.parse(this.timezonesValue)
    this.selectTarget.addEventListener("change", () => this.checkTimeZone())
    this.messageTarget.addEventListener("change", this.handleMessageChange.bind(this))
    this.checkTimeZone()
  }

  checkTimeZone() {
    const selectedTimeZone = this.selectTarget.value
    const browserTimeZone = this.convertBrowserTimeZone(Intl.DateTimeFormat().resolvedOptions().timeZone)

    if (selectedTimeZone !== browserTimeZone) {
      this.showMessage(browserTimeZone)
    } else {
      this.messageTarget.classList.add("hidden")
    }
  }

   handleMessageChange(event) {
    if (event.target.matches('input[data-update-timezone]:checked')) {
      event.preventDefault()
      this.updateTimeZone(event)
    }
  }

  showMessage(browserTimeZone) {
    this.messageTarget.innerHTML = `
        <div class="flex items-start">
          <div class="flex items-center h-5">
            <input data-update-timezone class="w-5 h-5 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-primary-600 dark:ring-offset-gray-800" type="checkbox">
          </div>
          <div class="ml-3 text-sm">
            <label class="text-sm font-medium text-gray-900 dark:text-white" for="page_main_menu">Your browser time zone, <strong>${browserTimeZone}</strong>, is different from the selected time zone, <strong>${this.selectTarget.value}</strong>. <br>Do you want us to update it for you?</label>
          </div>
    </div>`
    this.messageTarget.classList.remove("hidden")
  }

  updateTimeZone(event) {
    event.preventDefault()
    const browserTimeZone = this.convertBrowserTimeZone(Intl.DateTimeFormat().resolvedOptions().timeZone)
    this.selectTarget.value = browserTimeZone
    this.messageTarget.classList.add("hidden")
  }

  convertBrowserTimeZone(browserTimeZone) {
    return this.timeZoneMapping[browserTimeZone] || browserTimeZone
  }
}
