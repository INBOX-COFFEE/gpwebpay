module Payments
  class Master < Base
    def payment_type
      "master"
    end

    def order_number
      "00100607"
    end

    def card_holder
      OpenStruct.new(
        name: "Jon Doe",
        email: "email@example.com",
        phone_country: 420,
        phone: "777111222",
        mobile_phone_country: 420,
        mobile_phone: "555333222",
      )
    end

    def address_match
      "Y"
    end

    def shipping
      OpenStruct.new(
        name: "Jon Doe",
        address1: "Made Up 10",
        city: "NonExistent",
        postal_code: "11111",
        country: 203,
      )
    end

    def billing
      shipping
    end
  end
end
