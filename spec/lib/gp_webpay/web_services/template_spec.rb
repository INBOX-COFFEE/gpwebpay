RSpec.describe GpWebpay::WebServices::Template do
  let(:template) { GpWebpay::WebServices::Template.new }
  let(:payment) { Payments::Default.new }
  let(:recurring_payment) { Payments::Recurring.new }
  let(:payment_attributes) { GpWebpay::PaymentAttributes.new(payment) }

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

  describe "get_payment_detail" do
    it "builds correct XML request" do
      wsdl = Wsdl::Validator.new
      request = template.get_payment_detail(payment_attributes.to_h)
      expect(wsdl.errors_for(request)).to be_empty
    end
  end

  describe "get_payment_status" do
    it "builds correct XML request" do
      wsdl = Wsdl::Validator.new
      request = template.get_payment_status(payment_attributes.to_h)
      expect(wsdl.errors_for(request)).to be_empty
    end
  end

  describe "get_master_payment_status" do
    it "builds correct XML request" do
      wsdl = Wsdl::Validator.new
      request = template.get_master_payment_status(payment_attributes.to_h)
      expect(wsdl.errors_for(request)).to be_empty
    end
  end

  describe "request_attributes" do
    it "returns correct attrs for process_regular_subscription_payment" do
      Timecop.travel("1.3.2021")
      allow_any_instance_of(GpWebpay::Verification)
        .to receive(:merchant_key).and_return("XXX")
      allow_any_instance_of(String)
        .to receive(:sign).and_return("digest")

      attrs = recurring_payment.send(:request_attributes, "processRegularSubscriptionPayment")

      expect(attrs).to eq({
        :message_id=>"100101001234processRegularSubscriptionPayment1614553200",
        :merchant_number=>1234,
        :order_number=>1001,
        :digest=>"ZGlnZXN0",
        :merchant_order_number=>1001,
        :master_order_number=>"00100607",
        :amount=>100,
        :capture_flag=>1,
        :card_holder_name=>"Jon Doe",
        :card_holder_email=>"email@example.com",
        :card_holder_phone_country=>420,
        :card_holder_phone=>"777111222",
        :card_holder_mobile_phone_country=>420,
        :card_holder_mobile_phone=>"555333222",
        :address_match=>"Y",
        :billing_name=>"Jon Doe",
        :billing_address1=>"Made Up 10",
        :billing_city=>"NonExistent",
        :billing_postal_code=>"11111",
        :billing_country=>203,
        :shipping_name=>"Jon Doe",
        :shipping_address1=>"Made Up 10",
        :shipping_city=>"NonExistent",
        :shipping_postal_code=>"11111",
        :shipping_country=>203,
        :currency=>103
      })
      Timecop.return
    end

    it "returns correct attrs for get_payment_detail" do
      Timecop.travel("1.3.2021")
      allow_any_instance_of(GpWebpay::Verification)
        .to receive(:merchant_key).and_return("XXX")
      allow_any_instance_of(String)
        .to receive(:sign).and_return("digest")

      attrs = payment.send(:request_attributes, "getPaymentDetail")

      expect(attrs).to eq({
        :digest=>"ZGlnZXN0",
        :merchant_number=>1234,
        :message_id=>"100101001234getPaymentDetail1614553200",
        :order_number=>1001
      })
      Timecop.return
    end

    it "returns correct attrs for get_payment_status" do
      Timecop.travel("1.3.2021")
      allow_any_instance_of(GpWebpay::Verification)
        .to receive(:merchant_key).and_return("XXX")
      allow_any_instance_of(String)
        .to receive(:sign).and_return("digest")

      attrs = payment.send(:request_attributes, "getPaymentStatus")

      expect(attrs).to eq({
        :digest=>"ZGlnZXN0",
        :merchant_number=>1234,
        :message_id=>"100101001234getPaymentStatus1614553200",
        :order_number=>1001
      })
      Timecop.return
    end

    it "returns correct attrs for get_master_payment_status" do
      Timecop.travel("1.3.2021")
      allow_any_instance_of(GpWebpay::Verification)
        .to receive(:merchant_key).and_return("XXX")
      allow_any_instance_of(String)
        .to receive(:sign).and_return("digest")

      attrs = payment.send(:request_attributes, "getMasterPaymentStatus")

      expect(attrs).to eq({
        :digest=>"ZGlnZXN0",
        :merchant_number=>1234,
        :message_id=>"100101001234getMasterPaymentStatus1614553200",
        :order_number=>1001
      })
      Timecop.return
    end
  end
end
