RSpec.describe GpWebpay::PaymentAttributes do
  let(:payment) { Payments::Default.new }
  let(:payment_attributes) { GpWebpay::PaymentAttributes.new(payment) }
  let(:recurring_payment) { Payments::Recurring.new }
  let(:recurring_attributes) do
    GpWebpay::PaymentAttributes.new(recurring_payment, true, "processRegularSubscriptionPayment")
  end

  it "builds correct hash with all attributes" do
    expect(payment_attributes.to_h).to eq({
      :merchant_number => 1234,
      :operation => "CREATE_ORDER",
      :order_number => 1001,
      :amount_in_cents => 100,
      :currency => 103,
      :deposit_flag => 1,
      :redirect_url => "https://test",
    })
  end

  it "adds DESCRIPTION to hash" do
    allow(payment).to receive(:description).and_return("Description of payment")

    expect(payment_attributes.to_h).to eq({
      :merchant_number => 1234,
      :operation => "CREATE_ORDER",
      :order_number => 1001,
      :amount_in_cents => 100,
      :currency => 103,
      :deposit_flag => 1,
      :redirect_url => "https://test",
      :description => "Description of payment",
    })
  end

  it "builds correct hash for recurring (many more attrs.)" do
    Timecop.travel("1.3.2021")
    expect(recurring_attributes.to_h).to eq({
      :message_id => "100101001234processRegularSubscriptionPayment1614553200",
      :bank_id => "0100",
      :merchant_number => 1234,
      :order_number => 1001,
      :master_order_number => "00100607",
      :merchant_order_number => 1001,
      :amount_in_cents => 100,
      :capture_flag => 1,
      :"card_holder.name" => "Jon Doe",
      :"card_holder.email" => "email@example.com",
      :"card_holder.phone_country" => 420,
      :"card_holder.phone" => "777111222",
      :"card_holder.mobile_phone_country" => 420,
      :"card_holder.mobile_phone" => "555333222",
      :address_match => "Y",
      :"billing.name" => "Jon Doe",
      :"billing.address1" => "Made Up 10",
      :"billing.city" => "NonExistent",
      :"billing.postal_code" => "11111",
      :"billing.country" => 203,
      :"shipping.name" => "Jon Doe",
      :"shipping.address1" => "Made Up 10",
      :"shipping.city" => "NonExistent",
      :"shipping.postal_code" => "11111",
      :"shipping.country" => 203,
    })
    Timecop.return
  end
end
