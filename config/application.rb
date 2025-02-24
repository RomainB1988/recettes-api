require_relative "boot"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RecettesApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Ensure API-Only compatibility and add necessary middleware
    config.api_only = true

    # Autoload lib directory (optional, but useful)
    config.autoload_lib(ignore: %w[assets tasks])

    # Enable session management for Devise in API mode
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
    config.middleware.use Warden::Manager do |manager|
      manager.failure_app = Devise::FailureApp
    end

    # Optional: Set default time zone
    # config.time_zone = "Paris"

    # Optional: Eager load additional paths
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
