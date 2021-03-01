require "uri"
require "net/http"

class Exmo::Public::Client
  attr_reader :url, :https, :body

  def self.create(request, body)
    base_url = 'https://api.exmo.com'
    version = 'v1.1'
    new(base_url, version, request, body)
  end

  def initialize(base_url, version, request, body)
    @url = URI("#{base_url}/#{version}/#{request}")
    @https = Net::HTTP.new(url.host, url.port)
    @https.use_ssl = true
    @body = body
  end

  def call
    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/x-www-form-urlencoded"
    request.body = body
    https.request(request)

    response= https.request(request)
    JSON.parse(response.read_body)
  end
end
