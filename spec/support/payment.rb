class Payment
  include GpWebpay::Payment

  def initialize
    self.redirect_url = "https://test"
  end

  def order_number
    1001
  end

  def payment_type
    "default"
  end

  def amount_in_cents
    100
  end

  def currency
    103
  end
end
