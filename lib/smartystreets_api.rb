require "smartystreets_api/version"

module SmartyStreetsApi
  class << self
    attr_accessor :config
  end

  def self.configuration
    unless @config
      configure
    end

    @config
  end

  def self.configure
    self.config ||= Configuration.new
    yield(config)
  end

  class Configuration
    attr_accessor :auth_id, :auth_token, :base_url

    def initialize
      @auth_id = "AUTH-ID"
      @auth_token = "AUTH-TOKEN"
      @base_url = "api.smartystreets.com"
    end

    def auth_args
      { "auth-id" => @auth_id, "auth-token" => @auth_token }
    end
  end

  module Decorators
  end
end

require "smartystreets_api/monkey_patches"
require "smartystreets_api/exceptions"
require "smartystreets_api/decorators/base_decorator"
require "smartystreets_api/decorators/us_format"
require "smartystreets_api/decorators/international_format"
require "smartystreets_api/api_client"
require "smartystreets_api/us_street_address"
require "smartystreets_api/international_street_address"
