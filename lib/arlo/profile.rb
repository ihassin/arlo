module Arlo
  class API
    def get_profile
      profile = get 'https://arlo.netgear.com/hmsweb/users/profile'
      @profile = JSON.parse(profile.body)
    end
  end
end
