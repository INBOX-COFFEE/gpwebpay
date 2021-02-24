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

    def card_holder
      OpenStruct.new(
        name: "Jon Doe",
        email: "email@example.com",
        phone_country: "CZ",
        phone: "777111222",
        mobile_phone_country: "CZ",
        mobile_phone: "555333222",
      )
    end

    def address_match
      true
    end

    def shipping
      OpenStruct.new(
        name: "Jon Doe",
        address1: "Made Up 10",
        city: "NonExistent",
        postal_code: "11111",
        country: "CZ",
      )
    end

    def billing
      shipping
    end

    def currency
      103
    end
  end
end
