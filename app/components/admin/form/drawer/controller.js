import { Controller } from "@hotwired/stimulus"
export default class extends Controller {

  // This controller is used to ensure only one drawer is open at a time
  // When one opens all the others are closed
  connect() {
    document.addEventListener("turbo:load", () => this.initializeDrawer())
    this.initializeDrawer()
  }

  initializeDrawer() {
    if (!this.element) return
    const observer = new MutationObserver((mutations) => {
      mutations.forEach((mutation) => {
        if (mutation.type === 'attributes' && mutation.attributeName === 'aria-hidden') {
          this.onDrawerInitialized(this.element)
          observer.disconnect()
        }
      })
    })
    observer.observe(this.element, { attributes: true })
  }

  onDrawerInitialized(drawerElement) {
    this.drawer = FlowbiteInstances.getInstance('Drawer', drawerElement.id)
    if (this.drawer) {
      this.drawer.updateOnShow(() => {
        const event = new CustomEvent('drawer:shown', { detail: { drawerId: drawerElement.id }})
        document.dispatchEvent(event)

        const drawers = FlowbiteInstances.getInstances("Drawer")
        Object.values(drawers).forEach(drawer => {
          if (drawer._instanceId !== drawerElement.id) {
            if (drawer._targetEl.hasAttribute('data-content-drawer')) {
              drawer.hide()
            }
          }
        });
      })
    }
  }
}