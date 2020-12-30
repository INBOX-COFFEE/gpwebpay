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

RSpec.describe GpWebpay::PaymentAttributes do
  let(:payment) { Payment.new }
  let(:payment_attributes) { GpWebpay::PaymentAttributes.new(payment) }

  it "build correct hash with all attributes" do
    expect(payment_attributes.to_h).to eq({
      "MERCHANTNUMBER" => 1234,
      "OPERATION" => "CREATE_ORDER",
      "ORDERNUMBER" => 1001,
      "AMOUNT" => 100,
      "CURRENCY" => 103,
      "DEPOSITFLAG" => 1,
      "URL" => "https://test",
    })
  end

  it "add DESCRIPTION to hash" do
    allow(payment).to receive(:description).and_return("Description of payment")

    expect(payment_attributes.to_h).to eq({
      "MERCHANTNUMBER" => 1234,
      "OPERATION" => "CREATE_ORDER",
      "ORDERNUMBER" => 1001,
      "AMOUNT" => 100,
      "CURRENCY" => 103,
      "DEPOSITFLAG" => 1,
      "URL" => "https://test",
      "DESCRIPTION" => "Description of payment",
    })
  end
end
