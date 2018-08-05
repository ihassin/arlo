require 'net/http'
require 'uri'
require 'json'
require 'openssl'

module Arlo
  class API
    def get url
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri)
      request.add_field('Content-Type', 'application/json;charset=UTF-8')
      request.add_field('Authorization', @token)

      http.request(request)
    end

    def post url, payload, xheaders = nil
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri)

      headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        'Authorization': @token
      }

      headers.merge!(xheaders) if xheaders

      headers.each do |key, value|
        request.add_field(key, value)
      end
      request.body = payload.to_json

      http.request(request)
    end
  end
end
