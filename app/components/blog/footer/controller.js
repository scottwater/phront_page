import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["footer"]

  connect() {
    this.adjustFooter()
    window.addEventListener('resize', this.adjustFooter.bind(this))
  }

  disconnect() {
    window.removeEventListener('resize', this.adjustFooter.bind(this))
  }

  footerElement() {
    return (this.hasFooterTarget && this.footerTarget) || this.element
  }

  adjustFooter() {
    if (document.body.offsetHeight <= window.innerHeight) {
      this.footerElement().classList.add('fixed', 'bottom-0')
      this.footerElement().classList.remove('relative')
    } else {
      this.footerElement().classList.add('relative')
      this.footerElement().classList.remove('fixed', 'bottom-0')
    }
  }
}