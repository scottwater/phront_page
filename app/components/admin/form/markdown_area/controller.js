import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage";
export default class extends Controller {

  static values = { url: String,  cdn: String };

  connect() {
    if (!this.urlValue) {
      this.urlValue = "/rails/active_storage/direct_uploads"
    }

    this.element.addEventListener("paste", this.pasteUpload.bind(this));
    this.element.addEventListener("drop", this.dropUpload.bind(this));
    this.bindEvents();
  }

  bindEvents() {
    this.element.addEventListener("dragenter", this.addBorder.bind(this))
    this.element.addEventListener("dragleave", this.removeBorder.bind(this))
    this.element.addEventListener("drop", this.removeBorder.bind(this))
  }

  addBorder(event) {
    event.preventDefault()
    this.element.classList.add("border-2", "border-red-500")
  }

  removeBorder(event) {
    event.preventDefault()
    this.element.classList.remove("border-2", "border-red-500")
  }

  dropUpload(event) {
    event.preventDefault();
    this.uploadFiles(event.dataTransfer.files);
  }

  pasteUpload(event) {
    if (!event.clipboardData.files.length) return;

    event.preventDefault();
    this.uploadFiles(event.clipboardData.files);
  }

  uploadFiles(files) {
    Array.from(files).forEach(file => this.uploadFile(file));
  }

  uploadFile(file) {
    const upload = new DirectUpload(file, this.urlValue);

    upload.create((error, blob) => {
      if (error) {
        console.log("Error");
      } else {
        const text = this.markdownLink(blob);
        const start = this.element.selectionStart;
        const end = this.element.selectionEnd;
        this.element.setRangeText(text, start, end);
      }
    });
  }

  markdownLink(blob) {
    const prefix = (this.isImage(blob.content_type) ? '!' : '');
    const filename = blob.filename;
    if (this.cdnValue) {
    const url = new URL(this.cdnValue);
    if (url.pathname.endsWith("/")) {
      url.pathname = `${url.pathname}${blob.key}`;
    } else {
      url.pathname = `${url.pathname}/${blob.key}`;
    }
    return `${prefix}[${filename}](${url})\n`;
    } else {
      return `${prefix}[${filename}](/rails/active_storage/blobs/${blob.signed_id}/${filename})\n`;
    }
  }

  isImage(contentType) {
    return ["image/jpeg", "image/gif", "image/png"].includes(contentType);
  }
}
