# Pin npm packages by running ./bin/importmap

pin "application"
pin "@rails/activestorage", to: "activestorage.esm.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "flowbite", to: "https://cdn.jsdelivr.net/npm/flowbite@2.4.1/dist/flowbite.turbo.min.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin_all_from "app/components", under: "controllers", to: ""
pin "stimulus-textarea-autogrow" # @4.1.0
