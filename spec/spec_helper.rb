$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "smartystreets_api"
require "vcr"
require "yaml"

if File.exist?("#{File.dirname(__FILE__)}/credentials.yml")
  CREDENTIALS = YAML.load_file("#{File.dirname(__FILE__)}/credentials.yml")
else
  CREDENTIALS = YAML.load_file("#{File.dirname(__FILE__)}/credentials.sample.yml")
end

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.default_cassette_options = { match_requests_on: [:method, :host, :path, :query, :body] }
  config.hook_into :webmock
  config.filter_sensitive_data("AUTH-ID") { CREDENTIALS["auth-id"] }
  config.filter_sensitive_data("AUTH-TOKEN") { CREDENTIALS["auth-token"] }
end

SmartyStreetsApi.configure do |config|
  config.auth_id = CREDENTIALS["auth-id"]
  config.auth_token = CREDENTIALS["auth-token"]
end
