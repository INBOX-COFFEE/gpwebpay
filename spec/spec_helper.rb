require "bundler/setup"
require "gp_webpay"
require "pry"
require "wasabi"
require "timecop"

require "support/payments/base"
require "support/payments/default"
require "support/payments/master"
require "support/payments/recurring"
require "support/vcr"
require "support/wsdl_validator"

require "webmock/rspec"
WebMock.disable_net_connect!(allow_localhost: true)

require "simplecov"
SimpleCov.start

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"

  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  GpWebpay.configure do |config|
    config.merchant_number = 1234
    config.merchant_pem_path = "certs/file.pem"
    config.merchant_password = "password"
    config.debug = true
  end
end
