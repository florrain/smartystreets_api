# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smartystreets_api/version'

Gem::Specification.new do |spec|
  spec.name          = "smartystreets_api"
  spec.version       = SmartyStreetsApi::VERSION
  spec.authors       = ["florrain"]
  spec.email         = ["lorrain.florian@gmail.com"]

  spec.summary       = "Ruby API client for SmartyStreets"
  spec.description   = "A simple and dependency free API GEM for https://smartystreets.com/, the address verification API."
  spec.homepage      = "https://github.com/florrain/smartystreets_api"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "vcr", "~> 3.0.3"
  spec.add_development_dependency "webmock", "~> 1.21.0"
end
