host = ENV['REDIS_HOST']
port = ENV['REDIS_PORT']
db = ENV['REDIS_DB']

url = "redis://#{host}:#{port}/#{db}"

Redis.current = Redis.new(url: url)
