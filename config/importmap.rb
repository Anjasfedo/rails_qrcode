# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Pin modules from external URLs
pin "@zxing/library", to: "https://ga.jspm.io/npm:@zxing/library@0.21.0/esm/index.js"
pin "ts-custom-error", to: "https://ga.jspm.io/npm:ts-custom-error@3.3.1/dist/custom-error.mjs"

pin "@rails/ujs", to: "https://ga.jspm.io/npm:@rails/ujs@7.1.3-2/app/assets/javascripts/rails-ujs.esm.js"