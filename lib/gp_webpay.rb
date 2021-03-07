require "gp_webpay/config"
require "gp_webpay/payment_attributes"
require "gp_webpay/payment"
require "gp_webpay/version"
require "gp_webpay/verification"
require "gp_webpay/web_services"

module GpWebpay
  class << self
    attr_writer :logger

    def logger
      @logger ||= Logger.new($stdout).tap do |log|
        log.progname = self.name
      end
    end
  end
end
