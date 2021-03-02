module Payments
  class Recurring < Base
    def payment_type
      "recurring"
    end

    def master_order_number
      "00100607"
    end
  end
end
