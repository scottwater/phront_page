import { Controller } from "@hotwired/stimulus"
// via https://www.driftingruby.com/episodes/unsaved-changes
export default class extends Controller {
  hasChanges = false
  UNSAVED_CHANGES_MESSAGE = "You have unsaved changes. Are you sure you want to leave?"
  initialize() {
    this.setChanges = this.setChanges.bind(this)
    this.promptUser = this.promptUser.bind(this)
    this.handleAnchorClick = this.handleAnchorClick.bind(this)
  }

  connect() {
    console.log("Unsaved Changes Controller Connected")
    this.element.addEventListener("input", this.setChanges)
    window.addEventListener("beforeunload", this.promptUser)
    document.addEventListener("click", this.handleAnchorClick)
  }

  disconnect() {
    this.element.removeEventListener("input", this.setChanges)
    window.removeEventListener("beforeunload", this.promptUser)
    document.removeEventListener("click", this.handleAnchorClick)
  }

  setChanges() {
    this.hasChanges = true
  }

  promptUser(event) {
    if (this.hasChanges) {
      event.preventDefault()
      event.returnValue = this.UNSAVED_CHANGES_MESSAGE
    }
  }

  handleAnchorClick(event) {
    if (this.hasChanges && event.target.closest("a") && !event.target.matches('[data-skip-unsaved-check]')) {
      if (!confirm(this.UNSAVED_CHANGES_MESSAGE)) {
        event.preventDefault()
      }
    }
  }
}
