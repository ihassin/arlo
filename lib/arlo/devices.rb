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

    def set_siren_on(device, duration)
      device_id = device['deviceId']

      payload = {
        'from': 'arlogem',
        'to': device_id,
        'action': 'set',
        'transId': SecureRandom.uuid,
        'publishResponse': true,
        'resource': 'siren',
        'properties': {
          'duration': duration,
          'pattern': 'alarm',
          'sirenState': 'on',
          'volume': 8
        }
      }

      ret_val = post("https://arlo.netgear.com/hmsweb/users/devices/notify/#{device_id}",
                     payload, 'xcloudId': device['xCloudId'])

      JSON.parse(ret_val.body)
    end

    def take_snapshot(camera)
      camera_id = camera['deviceId']

      ret_val = start_stream(camera, camera_id)
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

      stop_stream(camera)
      snapshot_ret_val
    end

    def record_video(camera, duration)
      camera_id = camera['deviceId']
      parent_id = camera['parentId']

      ret_val = start_stream(camera, parent_id)
      return ret_val unless ret_val['success']

      # ret_val['data']['url']
      payload = {
        'xcloudId': camera['xCloudId'],
        'parentId': parent_id,
        'deviceId': camera_id,
        'olsonTimeZone': camera['properties']['olsonTimeZone']
      }

      ret_val = post('https://arlo.netgear.com/hmsweb/users/devices/startRecord',
                     payload, 'xcloudId': camera['xCloudId'])

      sleep(duration)

      stop_stream(camera)

      JSON.parse(ret_val.body)
    end

    private

    def stop_stream(camera)
      camera_id = camera['deviceId']

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
    end

    def start_stream(camera, dest)
      camera_id = camera['deviceId']
      payload = {
        'to': dest,
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
      JSON.parse(ret_val.body)
    end
  end
end
