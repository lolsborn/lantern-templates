require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  # Compress CSS using a preprocessor
  # config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.asset_host = "http://assets.example.com"

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for Apache
  # config.action_dispatch.x_sendfile_header = "X-Accel-Redirect" # for NGINX

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies
  config.force_ssl = true

  # Log to STDOUT by default
  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }

  # Prepend all log lines with the following tags
  config.log_tags = [:request_id]

  # Info include generic and useful information about system operation, but avoids logging too much
  # information to avoid inadvertent exposure of personally identifiable information (PII). If you
  # want to log everything, set the level to "debug".
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Use a different cache store in production
  config.cache_store = :redis_cache_store, { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }

  # Use a real queuing backend for Active Job (and separate queues per environment)
  config.active_job.queue_adapter = :sidekiq
  config.active_job.queue_name_prefix = "{{project_name}}_production"

  # Disable serving static files from the `/public` folder by default since
  # Apache or NGINX already handles this
  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  config.action_mailer.perform_caching = false

  # Ignore bad email addresses and do not raise email delivery errors
  # Set this to true and configure the email server for immediate delivery to raise delivery errors
  config.action_mailer.raise_delivery_errors = false

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation cannot be found)
  config.i18n.fallbacks = true

  # Don't log any deprecations
  config.active_support.report_deprecations = false

  # Do not dump schema after migrations
  config.active_record.dump_schema_after_migration = false

  # Enable DNS rebinding protection and other `Host` header attacks
  # config.hosts = [
  #   "example.com",     # Allow requests from example.com
  #   /.*\.example\.com/ # Allow requests from subdomains like `www.example.com`
  # ]
  # Skip DNS rebinding protection for the default health check port
  # config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
end