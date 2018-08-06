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

    def arm_device(device, armed)
      device_id = device['deviceId']
      payload = {
        'from': 'arlogem',
        'to': device_id,
        'action': 'set',
        'resource': 'modes',
        'transId': SecureRandom.uuid,
        'publishResponse': true,
        'properties': {
          'active': armed ? 'mode1' : 'mode0'
        }
      }

      ret_val = post("https://arlo.netgear.com/hmsweb/users/devices/notify/#{device_id}",
                     payload, 'xcloudId': device['xCloudId'])

      JSON.parse(ret_val.body)
    end

    def take_snapshot(camera)
      camera_id = camera['deviceId']

      payload = {
        'to': camera_id,
        'from': 'ArloGem',
        'resource': "cameras/#{camera_id}",
        'action': 'set',
        'publishResponse': true,
        'transId': SecureRandom.uuid,
        'properties': {
            'activityState': 'startUserStream',
            'cameraId': camera_id
        }
      }

      ret_val = post('https://arlo.netgear.com/hmsweb/users/devices/startStream',
                     payload, 'xcloudId': camera['xCloudId'])

      ret_val = JSON.parse(ret_val.body)
      return ret_val unless ret_val['success']

      payload = {
        'cameraId': camera_id,
        'parentId': camera_id,
        'deviceId': camera_id,
        'olsonTimeZone': camera['properties']['olsonTimeZone']
      }

      ret_val = post('https://arlo.netgear.com/hmsweb/users/devices/takeSnapshot',
                     payload, 'xcloudId': camera['xCloudId'])

      snapshot_ret_val = JSON.parse(ret_val.body)

      payload = {
          'to': camera_id,
          'from': 'ArloGem',
          'resource': "cameras/#{camera_id}",
          'action': 'set',
          'publishResponse': true,
          'transId': SecureRandom.uuid,
          'properties': {
              'activityState': 'stopUserStream',
              'cameraId': camera_id
          }
      }

      ret_val = post('https://arlo.netgear.com/hmsweb/users/devices/stopStream',
                     payload, 'xcloudId': camera['xCloudId'])

      JSON.parse(ret_val.body)
      snapshot_ret_val
    end

    def record_video(camera, duration)
      camera_id = camera['deviceId']
      parent_id = camera['parentId']

      payload = {
          'to': parent_id,
          'from': 'ArloGem',
          'resource': "cameras/#{camera_id}",
          'action': 'set',
          'responseUrl': '',
          'publishResponse': true,
          'transId': SecureRandom.uuid,
          'properties': {
              'activityState': 'startUserStream',
              'cameraId': camera_id
          }
      }

      ret_val = post('https://arlo.netgear.com/hmsweb/users/devices/startStream',
                     payload, 'xcloudId': camera['xCloudId'])

      ret_val = JSON.parse(ret_val.body)
      payload = {
          'xcloudId': camera['xCloudId'],
          'parentId': camera['parentId'],
          'deviceId': camera_id,
          'olsonTimeZone': camera['properties']['olsonTimeZone']

      }

      ret_val = post('https://arlo.netgear.com/hmsweb/users/devices/startRecord',
                     payload, 'xcloudId': camera['xCloudId'])

      JSON.parse(ret_val.body)

      sleep(duration)

      payload = {
          'xcloudId': camera['xCloudId'],
          'parentId': camera['parentId'],
          'deviceId': camera_id,
          'olsonTimeZone': camera['properties']['olsonTimeZone']

      }

      ret_val = post('https://arlo.netgear.com/hmsweb/users/devices/stopRecord',
                     payload, 'xcloudId': camera['xCloudId'])

      JSON.parse(ret_val.body)
    end
  end
end
