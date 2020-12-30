require "bundler/setup"
require "gp_webpay"
require "support/payment"

require "support/vcr"
require "pry"

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
  end
end
