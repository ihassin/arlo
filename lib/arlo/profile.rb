module Arlo
  class API
    def get_profile token
      profile = get('https://arlo.netgear.com/hmsweb/users/profile', token)
      JSON.parse(profile.body)
    end
  end
end
