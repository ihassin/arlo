module Arlo
  class API

    def initialize
      @token = login
      @devices = get_devices
      @profile = get_profile
    end

    def token
      @token
    end

    def devices
      @devices
    end

    def profile
      @profile
    end

    def login
      email = ENV['ARLO_EMAIL']
      raise 'Missing ARLO_EMAIL environment variable' unless email
      password = ENV['ARLO_PASSWORD']
      raise 'Missing ARLO_PASSWORD environment variable' unless password

      payload = {
        'email': email,
        'password': password
      }
      response = post('https://arlo.netgear.com/hmsweb/login/v2', payload)
      JSON.parse(response.body)['data']['token']
    end

  end
end
