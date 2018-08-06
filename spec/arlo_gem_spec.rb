RSpec.describe 'Arlo Gem' do
  context 'gem' do
    it 'has a version number' do
      expect(Arlo::VERSION).not_to be nil
    end
  end

  context 'functional' do
    before(:all) do
      VCR.use_cassette 'login' do
        @api = Arlo::API.new
      end
    end

    it 'authenticates' do
      VCR.use_cassette 'login' do
        expect(@api.token).not_to be nil
        expect(@api.devices).not_to be nil
        expect(@api.profile).not_to be nil
      end
    end

    context 'device operations' do
      it 'gets a device by name' do
        device_name = ENV['ARLO_TEST_DEVICE']
        raise 'Missing ARLO_TEST_DEVICE environment variable' unless device_name
        VCR.use_cassette 'devices' do
          device = @api.get_device_info device_name
          expect(device['deviceName']).to eq device_name
        end
      end

      it 'arms a device by name' do
        base_station_name = ENV['ARLO_TEST_BASE_STATION']
        raise 'Missing ARLO_TEST_BASE_STATION environment variable' unless base_station_name

        device = @api.get_device_info(base_station_name)
        VCR.use_cassette 'devices' do
          result = @api.arm_device(device, true)
          expect(result['success']).to eq true
        end
      end

    end

    context 'library operations' do
      it 'retrieves library index' do
        VCR.use_cassette 'library' do
          library = @api.get_library '20180802', '20180803'
          expect(library['success']).to eq true
        end
      end

    end

    context 'video' do
      it 'takes a snapshot' do
        camera_name = ENV['ARLO_TEST_DEVICE']
        raise 'Missing ARLO_TEST_DEVICE environment variable' unless camera_name

        camera = @api.get_device_info(camera_name)
        VCR.use_cassette 'camera' do
          result = @api.take_snapshot(camera)
          expect(result['success']).to eq true
        end
      end
    end

  end

end
