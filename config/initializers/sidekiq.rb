host = ENV['REDIS_HOST']
port = ENV['REDIS_PORT']
db = ENV['REDIS_DB']

url = "redis://#{host}:#{port}/#{db}"

Sidekiq.configure_server do |config|
  config.redis = { url: url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: url }
end
