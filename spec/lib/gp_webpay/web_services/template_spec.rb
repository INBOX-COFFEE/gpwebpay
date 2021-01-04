RSpec.describe GpWebpay::WebServices::Template do
  let(:template) { GpWebpay::WebServices::Template.new }

  describe "echo" do
    it "builds correct XML request" do
      wsdl = Wsdl::Validator.new
      request = template.echo
      expect(wsdl.errors_for(request)).to be_empty
    end
  end

  describe "process_regular_subscription_payment" do
    it "builds correct XML request" do
      wsdl = Wsdl::Validator.new
      request = template.process_regular_subscription_payment
      expect(wsdl.errors_for(request)).to be_empty
    end
  end

  describe "get_order_detail" do
    it "builds correct XML request" do
      wsdl = Wsdl::Validator.new
      request = template.get_order_detail
      expect(wsdl.errors_for(request)).to be_empty
    end
  end
end
