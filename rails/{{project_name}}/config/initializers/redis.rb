redis_url = ENV.fetch('REDIS_URL', 'redis://localhost:6379/0')

Rails.application.configure do
  config.cache_store = :redis_cache_store, { url: redis_url }
  config.session_store :redis_store,
                       servers: [redis_url],
                       expire_after: 90.minutes,
                       key: "_#{Rails.application.class.module_parent_name.downcase}_session"
end

# Sidekiq configuration
Sidekiq.configure_server do |config|
  config.redis = { url: redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url }
end