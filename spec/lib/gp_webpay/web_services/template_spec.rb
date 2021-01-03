RSpec.describe GpWebpay::WebServices::Template do
  let(:template) { GpWebpay::WebServices::Template.new }

  describe "echo" do
    it "builds correct XML request" do
      wsdl = Wsdl::Validator.new
      request = template.echo
      expect(wsdl.errors_for(request)).to be_empty
    end
  end
end
