RSpec.describe 'Arlo Gem' do
  context 'gem' do
    it 'has a version number' do
      expect(Arlo::VERSION).not_to be nil
    end
  end

  context 'functional' do
    before(:all) do
      @api = Arlo::API.new
    end

    it 'authenticates' do
      token = @api.get_token
      expect(token).not_to be nil
    end

    it 'retrieves the profile' do
      token = @api.get_token
      profile = @api.get_profile token
      expect(profile['data']).not_to be nil
    end

    it 'retrieves the devices' do
      token = @api.get_token
      devices = @api.get_devices token
      expect(devices['data']).not_to be nil
    end
  end

end
