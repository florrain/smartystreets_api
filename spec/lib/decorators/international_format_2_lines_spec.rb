require "spec_helper"

describe SmartyStreetsApi::Decorators::InternationalFormat2Lines do
  let(:rus_address) do
    {
      country: "RUS",
      address1: "ул. Фурштатская, д. 13",
      locality: "Петербург",
      postal_code: "191028"
    }
  end
  let(:rus_decorated_address) do
    {
      country: "RUS",
      organization: nil,
      address1: "13 Фурштатская Улица",
      address2: nil,
      administrative_area: "Петербург",
      locality: "Петербург",
      postal_code: "191028",
      postal_code_short: "191028"
    }
  end
  let(:uk_address_with_building) do
    {
      country: "GBR",
      organization: "Nildram Ltd",
      address1: "Ardenham Court Suite 3604",
      address2: "Oxford Road",
      locality: "AYLESBURY",
      postal_code: "HP19 3EQ"
    }
  end
  let(:uk_decorated_address_with_building) do
    {
      country: "GBR",
      organization: "Nildram Ltd",
      address1: "Ardenham Court",
      address2: "Oxford Road Suite 3604",
      administrative_area: "Buckinghamshire",
      locality: "Aylesbury",
      postal_code: "HP19 3EQ",
      postal_code_short: "HP19 3EQ"
    }
  end
  let(:ca_address_po_box) do
    {
      country: "CAN",
      organization: nil,
      address1: "PO BOX 1",
      address2: nil,
      administrative_area: "SK",
      locality: "Pilger",
      postal_code: "S0K 3G0"
    }
  end
  let(:ca_decorated_address_po_box) do
    {
      country: "CAN",
      organization: nil,
      address1: "PO Box 1",
      address2: nil,
      administrative_area: "SK",
      locality: "Pilger",
      postal_code: "S0K 3G0",
      postal_code_short: "S0K 3G0"
    }
  end

  it "should decorate correctly a simple address" do
    VCR.use_cassette("international/valid_rus") do
      response = SmartyStreetsApi::InternationalStreetAddress.get_single(rus_address)

      expect(described_class.new.call(response.first)).to eq(rus_decorated_address)
    end
  end

  it "should decorate an address with a building" do
    VCR.use_cassette("international/valid_uk_with_building") do
      response = SmartyStreetsApi::InternationalStreetAddress.get_single(uk_address_with_building)

      expect(described_class.new.call(response.first)).to eq(uk_decorated_address_with_building)
    end
  end

  it 'should replace address1 with address2 if empty' do
    VCR.use_cassette("international/valid_ca_po_box") do
      response = SmartyStreetsApi::InternationalStreetAddress.get_single(ca_address_po_box)

      expect(described_class.new.call(response.first)).to eq(ca_decorated_address_po_box)
    end
  end
end
