// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import 'flowbite';

window.document.addEventListener("turbo:render", (_event) => {
    window.initFlowbite();
});

window.document.addEventListener("turbo:submit-end", (_event) => {
  window.setTimeout(() => {
    window.initFlowbite();
  }, 10);
});