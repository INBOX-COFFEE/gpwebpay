RSpec.describe GpWebpay::WebServices do
  let(:payment) { Payment.new }

  describe "ws_echo" do
    it "builds correct XML request" do
      VCR.use_cassette "ws_echo" do
        @result = payment.ws_echo
      end
    end
  end
end
