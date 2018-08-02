module Arlo
  class API
    def get_profile token
      profile = get('https://arlo.netgear.com/hmsweb/users/profile', token)
      JSON.parse(profile.body)
    end

    private
    def get url, token
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(uri)
      request.add_field('Content-Type', 'application/json')
      request.add_field('Authorization', token)

      http.request(request)
    end
  end
end
