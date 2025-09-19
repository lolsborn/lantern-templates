require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module {{project_name.capitalize}}
  class Application < Rails::Application
    config.load_defaults 7.1

    # API-only application
    config.api_only = true

    # CORS configuration
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins Rails.env.development? ? '*' : ENV['CORS_ORIGINS']&.split(',')

        resource '*',
          headers: :any,
          methods: [:get, :post, :put, :patch, :delete, :options, :head],
          credentials: true
      end
    end

    # Session store
    config.session_store :cookie_store, key: '_{{project_name}}_session'

    # Time zone
    config.time_zone = 'UTC'

    # Generators configuration
    config.generators do |g|
      g.test_framework :rspec
      g.factory_bot dir: 'spec/factories'
      g.helper false
      g.stylesheets false
      g.javascripts false
      g.view_specs false
      g.routing_specs false
    end

    # Exception handling
    config.exceptions_app = self.routes
  end
end