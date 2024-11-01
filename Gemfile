# frozen_string_literal: true

source "https://rubygems.org"
ruby file: ".ruby-version"

gem "activerecord-typedstore"
gem "aws-sdk-s3", "~> 1.156", require: false
gem "bcrypt", "~> 3.1.7"
gem "bootsnap", require: false
gem "commonmarker"
gem "diffy"
gem "dry-initializer", "~> 3.1"
gem "honeybadger", "~> 5.15"
gem "importmap-rails"

gem "propshaft" # Propshaft needs to be listed before inline_svg. I a  not sure who is at fault here.
gem "inline_svg"

gem "keynote"
gem "litestack", "0.4.4"
gem "lograge"
gem "puma", ">= 5.0"
gem "requestjs-rails" # import maps should be loaded before this
gem "rails", "7.2.1"
gem "slowpoke"
gem "sqlite3", ">= 1.4"
gem "stimulus-rails"
gem "tailwind_merge"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "view_component-contrib", "~> 0.2.3"
gem "view_component", "~> 3.20"

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "erb_lint", require: false
  gem "faker"
  gem "lookbook", require: false
  gem "standard"
  gem "standard-rails"
end

group :development do
  gem "devpack"
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "capybara-playwright-driver"
  gem "minitest-reporters"
end
