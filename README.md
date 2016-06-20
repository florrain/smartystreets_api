# SmartyStreetsApi [![Build Status](https://travis-ci.org/florrain/smartystreets_api.svg?branch=master)](https://travis-ci.org/florrain/smartystreets_api)

Ruby client for smartystreets.com APIs. So far only the single US street address API has been implemented.

PRs are welcome!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'smartystreets_api'
```

Or install it yourself as:

    $ gem install smartystreets_api

## Usage
Configure the GEM first:
```ruby
# config/initializers/smartystreets_api.rb
SmartyStreetsApi.configure do |config|
	config.auth_id = "AUTH-ID"
	config.auth_token = "AUTH-TOKEN"
end
```

Then try to validate an address:
```ruby
address_args = {
  street: "114 Sansome Street",
  secondary: "Floor 5",
  city: "San Francisco",
  state: "CA",
  zipcode: "94104"
}

response = SmartyStreetsApi::UsStreetAddress.get_single(address_args)

#response
[
  {
    lines: {
      delivery_line_1: "114 Sansome St Fl 5",
      last_line: "San Francisco CA 94104-3812"
    },
    indexes: {
      input_index: 0,
      candidate_index: 0,
      delivery_point_barcode: "941043812053"
    },
    components: {
      primary_number: "114",
      street_name: "Sansome",
      street_suffix: "St",
      secondary_number: "5",
      secondary_designator: "Fl",
      city_name: "San Francisco",
      state_abbreviation: "CA",
      zipcode: "94104",
      plus4_code: "3812",
      delivery_point: "05",
      delivery_point_check_digit: "3"
    },
    metadata: {
      record_type: "H",
      zip_type: "Standard",
      county_fips: "06075",
      county_name: "San Francisco",
      carrier_route: "C015",
      congressional_district: "12",
      rdi: "Commercial",
      elot_sequence: "0163",
      elot_sort: "A",
      latitude: 37.79133,
      longitude: -122.40068,
      precision: "Zip9",
      time_zone: "Pacific",
      utc_offset: -8,
      dst: true
    },
    analysis: {
      dpv_match_code: "Y",
      dpv_footnotes: "AABB",
      dpv_cmra: "N",
      dpv_vacant: "N",
      active: "N",
      footnotes: "N#"
    }
}]
```

A decorator can reformat the address based on the components. Please make sure the format fits your need!!

```ruby
response = SmartyStreetsApi::UsStreetAddress.get_single(office)

decorated_address = SmartyStreetsApi::Decorators::UsFormat.new.call(response.first)

# decorated_address
{
  street: "114 Sansome St",
  secondary: "Fl 5",
  city: "San Francisco",
  state: "CA",
  zipcode: "94104",
  plus4_code: "3812"
}
```

## Development

After checking out the repo, run `bundle` to install dependencies. Then copy/paste `spec/credentials.sample.yml` to `spec/credentials.yml` and set your own credentials.
VCR is intended to hide them so no worries, as long as you don't commit hard-coded credentials in the code they won't be pushed in cassettes + you won't have to pay for the already passed tests.

Run `rake spec` to run the tests.

To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/florrain/smartystreets_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
