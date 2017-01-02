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
  let(:fra_address) do
    {
      country: "FRA",
      address1: "55 Rue du Faubourg Saint-Honoré",
      locality: "Paris",
      postal_code: "75008",
      geocode: true
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

  it "should find the address and return the longitude and latitude along to it" do
    VCR.use_cassette("international/valid_fra_with_geocode") do
      expect(described_class.get_single(fra_address)[0][:metadata]).to eq(
        {
          latitude: 48.87071,
          longitude: 2.31692,
          geocode_precision: "Premise",
          max_geocode_precision: "DeliveryPoint"
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
