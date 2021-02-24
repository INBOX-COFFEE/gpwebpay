module Payments
  class Recurring < Base
    def payment_type
      "recurring"
    end
  end
end
