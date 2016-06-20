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
      @auth_id = "unset_auth_id"
      @auth_token = "unset_auth_token"
      @base_url = "https://api.smartystreets.com"
    end

    def auth_args
      { "auth-id" => @auth_id, "auth-token" => @auth_token }
    end
  end

  module Decorators
  end
end

require "smartystreets_api/monkey_patches"
require "smartystreets_api/decorators/us_format"
require "smartystreets_api/us_street_address"
