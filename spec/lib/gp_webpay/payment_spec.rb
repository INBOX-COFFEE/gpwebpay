RSpec.describe GpWebpay::Payment do
  let(:payment) { Payments::Default.new }

  it "have all public methods" do
    expect(payment).to respond_to(:pay_url)
    expect(payment).to respond_to(:success?)
  end

  it "correctly generates pay_url" do
    allow_any_instance_of(GpWebpay::Verification)
      .to receive(:merchant_key).and_return("XXX")
    allow_any_instance_of(String)
      .to receive(:sign).and_return("digest")
    pay_url = payment.pay_url
    expect(pay_url)
      .to eq("https://test.3dsecure.gpwebpay.com/kb/order.do?AMOUNT=100&CURRENCY=103&DEPOSITFLAG=1&DIGEST=ZGlnZXN0&MERCHANTNUMBER=1234&OPERATION=CREATE_ORDER&ORDERNUMBER=1001&URL=https%3A%2F%2Ftest")
  end
end
