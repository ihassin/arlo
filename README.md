# Arlo

Get information about your Arlo account as well as your devices.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'arlo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arlo

## Testing

    ARLO_EMAIL=xxx ARLO_PASSWORD=yyy bundle exec rspec

## Usage

Please see the tests for client usage.

### get_token

Call this to gain access to the other APIs.

### get_profile

Call this to get your profile information.

### get_devices token

Call this to get device information.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/arlo. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Arlo project’s codebase, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/arlo/blob/master/CODE_OF_CONDUCT.md).

# Thanks

Thank you to [Roberto Gallea](http://www.robertogallea.com/blog/netgear-arlo-api) and [bburtin](https://github.com/bburtin/arlo-api) for their inspiring blog posts and repos.
