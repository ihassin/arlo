require 'net/http'
require 'uri'
require 'json'
require 'openssl'

module Arlo
  class API
    def initialize
      @@token = nil
    end

    def get_token
      return @@token if @@token
      email = ENV['ARLO_EMAIL']
      raise 'Missing ARLO_EMAIL environment variable' unless email
      password = ENV['ARLO_PASSWORD']
      raise 'Missing ARLO_PASSWORD environment variable' unless password

      payload = {
        "email": email,
        "password": password
      }
      response = post('https://arlo.netgear.com/hmsweb/login/v2', payload)
      @@token = JSON.parse(response.body)['data']['token']
    end

    private
    def post url, payload
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri)
      request.add_field('Content-Type', 'application/json')
      request.body = payload.to_json

      http.request(request)
    end
  end
end
