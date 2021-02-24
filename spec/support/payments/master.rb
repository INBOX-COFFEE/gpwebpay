module Payments
  class Master < Base
    def payment_type
      "master"
    end

    def order_number
      "00100607"
    end
  end
end
