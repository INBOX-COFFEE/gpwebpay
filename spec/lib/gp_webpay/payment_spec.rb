class Payment
  include GpWebpay::Payment
end

RSpec.describe GpWebpay::Payment do
  let(:payment) { Payment.new }

  it "have all public methods" do
    expect(payment).to respond_to(:pay_url)
    expect(payment).to respond_to(:success?)
  end
end
