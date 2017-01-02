require "spec_helper"

describe SmartyStreetsApi::UsStreetAddress do
  let(:office) do
    {
      street: "114 Sansome Street",
      secondary: "Floor 5",
      city: "San Francisco",
      state: "CA",
      zipcode: "94104"
    }
  end
  let(:chicago_address) do
    {
      street: "8 S Michigan Ave",
      secondary: "Floor 12",
      city: "Chicago",
      state: "IL",
      zipcode: "60603"
    }
  end

  context "Successful call" do
    it "should find a valid address" do
      VCR.use_cassette("valid") do
        expect(described_class.get_single(office)[0][:analysis][:dpv_match_code]).to eq("Y")
      end
    end

    it "should not find this one even though it exists" do
      VCR.use_cassette("usps_cant_find_this_one") do
        expect(described_class.get_single(chicago_address)[0][:analysis][:dpv_match_code]).to eq("S")
      end
    end

    it "should raise an exception when the response is not successful" do
      double_response = double("HTTP Response", code: 402)
      allow(Net::HTTP).to receive(:get_response).and_return(double_response)

      expect {
        described_class.get_single(chicago_address)
      }.to raise_error(SmartyStreetsApi::Exceptions::SevereApiError)
    end
  end

  context "Raise a SevereError when error responses" do
    before(:all) do
      fake_credentials
    end

    after(:all) do
      reset_credentials
    end

    let(:aus_address) do
      {
        country: "AUS",
        address1: "200 River Tce",
        locality: "Kangaroo Point",
        postal_code: "QLD 4169"
      }
    end

    it "should raise a SevereError if the credentials are incorrect" do
      VCR.use_cassette("unauthorized") do
        expect {
          SmartyStreetsApi::UsStreetAddress.get_single(office)
        }.to raise_error(SmartyStreetsApi::Exceptions::SevereApiError, "Unauthorized")
      end
    end
  end
end
