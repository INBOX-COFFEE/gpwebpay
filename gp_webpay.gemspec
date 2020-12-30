# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gp_webpay/version'

Gem::Specification.new do |spec|
  spec.name          = "gpwebpay"
  spec.version       = GpWebpay::VERSION
  spec.authors       = ["Andrej Antas"]
  spec.email         = ["andrej@antas.cz"]

  spec.summary       = %q{GP webpay, payments, SOAP, payment gateway}
  spec.homepage      = "https://github.com/redrick/gpwebpay"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activesupport'
  spec.add_runtime_dependency 'nokogiri'
  spec.add_runtime_dependency 'curb'

  spec.add_development_dependency "bundler", "~> 2.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.6.0"
end
