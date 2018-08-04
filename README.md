# Arlo

[![Gem Version](https://badge.fury.io/rb/arlo.svg)](https://badge.fury.io/rb/arlo) [![Build Status](https://travis-ci.org/ihassin/arlo.svg?branch=master)](https://travis-ci.org/ihassin/arlo)

Get information about your Arlo account as well as your devices.

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

    ARLO_TEST_DEVICE=ddd ARLO_EMAIL=xxx ARLO_PASSWORD=yyy bundle exec rspec

ARLO_TEST_DEVICE being the name of the device you want to test with

# Usage

Please see the tests for client usage.

Set up the environment variables reflecting your Arlo credentials:

    export ARLO_EMAIL=xxx
    export ARLO_PASSWORD=yyy

## get_token

Call this to gain access to the other APIs.

## get_profile

Call this to get your profile information.

## get_devices

Call this to get the list of devices (including basestations) registered with the account.

## get_device_info

Call this to get device information.

## get_library

Call this to get the library's index of all the recordings it has between the two supplied dates.

# TODO

* Provide a convenient interface to manage devices
* Control cameras (start/stop recordings)
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