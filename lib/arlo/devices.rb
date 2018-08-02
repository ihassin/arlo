module Arlo
  class API
    def get_devices token
      profile = get('https://arlo.netgear.com/hmsweb/users/devices', token)
      JSON.parse(profile.body)
    end
  end
end
