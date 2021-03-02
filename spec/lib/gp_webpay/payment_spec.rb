RSpec.describe GpWebpay::Payment do
  let(:payment) { Payments::Default.new }

  it "have all public methods" do
    expect(payment).to respond_to(:pay_url)
    expect(payment).to respond_to(:success?)
  end
end
