# Arlo

[![Gem Version](https://badge.fury.io/rb/arlo.svg)](https://badge.fury.io/rb/arlo) [![Build Status](https://travis-ci.org/ihassin/arlo.svg?branch=master)](https://travis-ci.org/ihassin/arlo)

Get and set information about your Arlo account as well as your devices.

# Installation

Add this line to your application's Gemfile:

```ruby
gem 'arlo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arlo

# Testing

## Set up environment variables in a local ```.env``` file:
    ARLO_EMAIL=your account email
    ARLO_PASSWORD=your account password
    ARLO_TEST_BASE_STATION=base-station name
    ARLO_TEST_DEVICE=a camera's name
    ARLO_SIREN_BASE_STATION=base-station with siren name

Run the tests

    bundle exec rspec

# Usage

Please see the tests for client usage.

Set up the environment variables reflecting your Arlo credentials:

    export ARLO_EMAIL=xxx
    export ARLO_PASSWORD=yyy

## get_profile

Call this to get your profile information.

```
api = Arlo::API.new
profile = api.get_profile
firstName = api.profile['data']['firstName']
```

Note: This method is implicitly called when instantiating the API object, so you can directly see the profile by:
```
api = Arlo::API.new
firstName = api.profile['data']['firstName']
```

## get_devices

Call this to get the list of devices (including basestations) registered with the account.

```
api = Arlo::API.new
devices = api.get_devices
first_device = api.devices['data'][0]
```

Note: This method is implicitly called when instantiating the API object, so you can directly see the devices by:
```
api = Arlo::API.new
first_device = api.devices['data'][0]
```

## get_device_info

Call this to get device information.

```
api = Arlo::API.new
camera1 = api.get_device_info 'Camera1"
```

## arm_device

Call this to arm or disarm a device

```
api = Arlo::API.new
camera1 = api.arm_device 'Camera1", true|false
```

## get_library

Call this to get the library's index of all the recordings it has between the two supplied dates.

```
api = Arlo::API.new
library = api.get_library '20180802', '20180803'
```

## take_snapshot

Call this to take a snapshot using a given camera.

```
api = Arlo::API.new
camera = @api.get_device_info(camera_name)
result = @api.take_snapshot(camera)
```

## record_video

Call this to take a snapshot using a given camera.

```
api = Arlo::API.new
camera = @api.get_device_info(camera_name)
result = @api.record_video(camera, 10)
```

## set_siren_on

Sound the siren for a determined duration

```
basestation = @api.get_device_info(basestation_name)
result = @api.set_siren_on(basestation, 3)  # siren will sound for 3 seconds
```

# TODO

* Record and take snapshots asynchronously
* Download videos

# Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

# Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ihassin/arlo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

# License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

# Code of Conduct

Everyone interacting in the Arlo project’s codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/arlo/blob/master/CODE_OF_CONDUCT.md).

# Thanks

Thank you to [Roberto Gallea](http://www.robertogallea.com/blog/netgear-arlo-api) and [bburtin](https://github.com/bburtin/arlo-api) for their inspiring blog posts and repos.

# Other work

Whats seems like a very comprehensive Python library by [jeffreydwalter](https://github.com/jeffreydwalter/arlo)

# Changelog

Check out the [changelog](https://github.com/ihassin/arlo/blob/master/changelog.md)
