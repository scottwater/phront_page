# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PhrontPage
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join("app/components")
    config.autoload_paths << "#{root}/lib"
    config.autoload_paths << "#{root}/app/views"
    config.autoload_paths << "#{root}/app/views/layouts"
    config.autoload_paths << "#{root}/app/views/components"
    config.view_component.preview_paths << Rails.root.join("app/components").to_s
    config.i18n.load_path += Rails.root.glob("config/locales/**/*.{rb,yml}")

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks generators])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    config.view_component.preview_controller = "PreviewController"
    config.lookbook_enabled = ENV["LOOKBOOK_ENABLED"] == "true" || Rails.env.development?
    require "lookbook" if config.lookbook_enabled
    config.lograge.enabled = true
    config.active_support.to_time_preserves_timezone = :zone
  end
end
