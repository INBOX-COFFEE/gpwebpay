RSpec.describe GpWebpay::Configuration do
  let(:config) { GpWebpay.config }

  describe "test environment" do
    it "store setup to config" do
      expect(config.merchant_number).to eq(1234)
      expect(config.merchant_pem_path).to eq("certs/file.pem")
      expect(config.merchant_password).to eq("password")
      expect(config.production?).to be_falsey
      expect(config.pay_url).to eq("https://test.3dsecure.gpwebpay.com/kb/order.do")
      expect(config.gpe_pem_path).to end_with("certs/muzo.signing_test.pem")
    end

    it "could read certificate file" do
      expect(File.read(config.gpe_pem_path)).to be_a(String)
    end
  end

  describe "production environment" do
    it "returns test url" do
      allow(config).to receive(:production?).and_return(true)
      expect(config.pay_url).to eq("https://3dsecure.gpwebpay.com/kb/order.do")
      expect(config.gpe_pem_path).to end_with("certs/muzo.signing_prod.pem")
    end

    it "could read certificate file" do
      allow(config).to receive(:production?).and_return(true)
      expect(File.read(config.gpe_pem_path)).to be_a(String)
    end
  end
end
