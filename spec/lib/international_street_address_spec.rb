require "spec_helper"

describe SmartyStreetsApi::InternationalStreetAddress do
  let(:aus_address1) do
    {
      country: "AUS",
      address1: "200 River Tce",
      locality: "Kangaroo Point",
      postal_code: "QLD 4169"
    }
  end
  let(:rus_address) do
    {
      country: "RUS",
      address1: "ул. Фурштатская, д. 13",
      locality: "Петербург",
      postal_code: "191028"
    }
  end

  it "should find a valid Australian address" do
    VCR.use_cassette("international/valid_aus") do
      expect(described_class.get_single(aus_address1)[0][:analysis]).to eq(
        {
          verification_status: "Verified",
          address_precision: "Premise",
          max_address_precision: "DeliveryPoint"
        }
      )
    end
  end

  it "should find a valid Russian address" do
    VCR.use_cassette("international/valid_rus") do
      expect(described_class.get_single(rus_address)[0][:analysis]).to eq(
        {
          verification_status: "Verified",
          address_precision: "Premise",
          max_address_precision: "DeliveryPoint"
        }
      )
    end
  end
end
