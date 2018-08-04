require 'net/http'
require 'uri'
require 'json'
require 'openssl'

module Arlo
  class API
    def get url, token
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri)
      request.add_field('Content-Type', 'application/json;charset=UTF-8')
      request.add_field('Authorization', token)

      http.request(request)
    end

    def post url, payload, token = nil
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri)
      request.add_field('Content-Type', 'application/json;charset=UTF-8')
      request.add_field('Authorization', token) if token
      request.body = payload.to_json

      http.request(request)
    end
  end
end
