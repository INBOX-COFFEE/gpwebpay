module Payments
  class Base
    include GpWebpay::Payment
    include GpWebpay::WebServices

    def initialize
      self.redirect_url = "https://test"
    end

    def order_number
      1001
    end

    def merchant_order_number
      order_number
    end

    def master_order_number
      1000
    end

    def amount_in_cents
      100
    end

    def currency
      103
    end
  end
end
