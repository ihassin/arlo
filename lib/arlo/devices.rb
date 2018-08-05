require 'securerandom'

module Arlo
  class API
    def get_devices
      devices = get 'https://arlo.netgear.com/hmsweb/users/devices'
      @devices = JSON.parse(devices.body)
    end

    def get_device_info(device_name)
      raise 'Missing device_name' unless device_name
      @devices['data'].select {|device| device['deviceName'] == device_name }[0]
    end

    def arm_device(base_station, armed)
      station_id = base_station['deviceId']
      payload = {
        'from': 'arlogem',
        'to': station_id,
        'action': 'set',
        'resource': 'modes',
        'transId': SecureRandom.uuid,
        'publishResponse': true,
        'properties': {
          'active': armed ? 'mode1' : 'mode0'
        }
      }

      ret_val = post("https://arlo.netgear.com/hmsweb/users/devices/notify/#{station_id}",
                     payload,
                     'xcloudId': base_station['xCloudId'])
      JSON.parse(ret_val.body)
    end
  end
end
