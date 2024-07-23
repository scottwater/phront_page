import { Controller } from "@hotwired/stimulus"
import { DirectUpload } from "@rails/activestorage";

export default class extends Controller {

  static values = { url: String,  cdn: String };
  static targets = [ "previewZone", "dropZone", "file"];

  connect() {
    console.log("Hello, Image Drop!")

    if (!this.urlValue) {
      this.urlValue = "/rails/active_storage/direct_uploads"
    }

    if (this.urlFileField.value) {
      this.previewZoneTarget.querySelector('img').setAttribute('src', this.urlFileField.value);
      this.toggleDisplayZones();
    }
  }

  get urlFileField() {
    return this.element.querySelector('input[type="hidden"]');
  }

  get inputField() {
    return this.dropZoneTarget.querySelector('input[type="file"]');
  }

  previewZoneTargetConnected(pz) {
    pz.querySelector('a').addEventListener('click', (event) => {
      event.preventDefault();
      this.removeUpload();
    });
  }

  dropZoneTargetConnected(dz) {

    dz.addEventListener('dragenter', (event) => {
      event.preventDefault();
    });

    dz.addEventListener('dragover', (event) => {
      event.preventDefault();
    });

    dz.addEventListener('drop', (event) => {
      this.dropUpload(event);
    });

    dz.addEventListener('paste', (event) => {
      this.pasteUpload(event);
    });

    this.inputField.addEventListener('change', (event) => {
      this.changeUpload(event);
    });
  }

  changeUpload(event) {
    this.uploadFiles(event.target.files);
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
        const imageUrl = this.markdownLink(blob);
        this.previewZoneTarget.querySelector('img').setAttribute('src', imageUrl);
        this.toggleDisplayZones()
        this.urlFileField.value = imageUrl;
      }
    });
  }

  removeUpload() {
    this.previewZoneTarget.querySelector('img').setAttribute('src', '');
    this.inputField.value = '';
    this.urlFileField.value = '';
    this.toggleDisplayZones()
  }

  toggleDisplayZones() {
    this.previewZoneTarget.classList.toggle('hidden');
    this.dropZoneTarget.classList.toggle('hidden');
  }

  markdownLink(blob) {
    if (this.cdnValue !== null && this.cdnValue.trim() !== "") {
    const url = new URL(this.cdnValue);

    if (url.pathname.endsWith("/")) {
      url.pathname = `${url.pathname}${blob.key}`;
    } else {
      url.pathname = `${url.pathname}/${blob.key}`;
    }

    return url;
    } else {
      return `/rails/active_storage/blobs/${blob.signed_id}/${blob.filename}`;
    }
  }

  isImage(contentType) {
    return ["image/jpeg", "image/gif", "image/png"].includes(contentType);
  }
}
