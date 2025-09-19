require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.server_timing = true

  # Cache configuration
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.cache_store = :redis_cache_store, { url: ENV.fetch('REDIS_URL', 'redis://localhost:6379/0') }
    config.public_file_server.headers = { "Cache-Control" => "public, max-age=#{2.days.to_i}" }
  else
    config.cache_store = :null_store
  end

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  # Print deprecation notices to stderr
  config.active_support.deprecation = :stderr
  config.active_support.disallowed_deprecation = :raise
  config.active_support.disallowed_deprecation_warnings = []

  # Raise exceptions for disallowed deprecations
  config.active_support.disallowed_deprecation = :raise

  # Raise error when a before_action's only/except options reference missing actions
  config.action_controller.raise_on_missing_callback_actions = true

  # Logging
  config.log_level = :debug
  config.log_tags = [:request_id]

  # Annotate rendered view with file names
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin
  # config.action_cable.disable_request_forgery_protection = true

  # Raise error when a before_action's only/except options reference missing actions
  config.action_controller.raise_on_missing_callback_actions = true
end