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

  end
end
