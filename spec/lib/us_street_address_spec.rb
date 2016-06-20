require "spec_helper"

describe SmartyStreetsApi::UsStreetAddress do
  context "Successful call" do
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
  end
end