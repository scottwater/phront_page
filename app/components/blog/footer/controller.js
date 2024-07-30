import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["footer"]

  connect() {
    this.adjustFooter()
    window.addEventListener('resize', this.adjustFooter)
  }

  disconnect() {
    window.removeEventListener('resize', this.adjustFooter)
  }

  footerElement() {
    return (this.hasFooterTarget && this.footerTarget) || this.element
  }

  adjustFooter = () => {
    const footer = this.footerElement()
    if (document.body.offsetHeight <= window.innerHeight) {
      footer.classList.add('fixed', 'bottom-0')
      footer.classList.remove('relative')
    } else {
      footer.classList.add('relative')
      footer.classList.remove('fixed', 'bottom-0')
    }
  }
}