module Arlo
  class API
    def get_devices token
      profile = get('https://arlo.netgear.com/hmsweb/users/devices', token)
      JSON.parse(profile.body)
    end

    def get_device_info device_name, device_list
      raise 'Missing device_name' unless device_name
      device_list['data'].select {|device| device['deviceName'] == device_name }[0]
    end
  end
end
