# frozen_string_literal: true

source "https://rubygems.org"
ruby file: ".ruby-version"
# Use main development branch of Rails
gem "rails", github: "rails/rails", branch: "7-2-stable"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 1.4"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem "tailwindcss-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"
gem "aws-sdk-s3", "~> 1.156", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false
  gem "erb_lint", require: false
  gem "lookbook", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "capybara-playwright-driver"
end

group :development, :test do
  gem "standard"
  gem "faker"
end

group :development do
  gem "devpack"
end

gem "authentication-zero", "~> 3.0"
# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem "bcrypt", "~> 3.1.7"

gem "view_component", "~> 3.13"
gem "view_component-contrib", "~> 0.2.2"

gem "dry-initializer", "~> 3.1"

gem "commonmarker"
gem "tailwind_merge"
gem "inline_svg"
gem "litestack", "0.4.4"
gem "keynote"
gem "activerecord-typedstore"
gem "lograge"
gem "slowpoke"

gem "honeybadger", "~> 5.15"
