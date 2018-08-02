RSpec.describe 'Arlo Gem' do
  context 'gem' do
    it 'has a version number' do
      expect(Arlo::VERSION).not_to be nil
    end
  end

  context 'functional' do
    before(:all) do
      @api = Arlo::API.new
      VCR.use_cassette 'get_token' do
        @token = @api.get_token
      end
    end

    it 'authenticates' do
      VCR.use_cassette 'get_token' do
        expect(@token).not_to be nil
      end
    end

    it 'retrieves the profile' do
      VCR.use_cassette 'profile' do
        profile = @api.get_profile @token
        expect(profile['data']).not_to be nil
      end
    end

    it 'retrieves the devices' do
      VCR.use_cassette 'devices' do
        devices = @api.get_devices @token
        expect(devices['data']).not_to be nil
      end
    end
  end

end
