require "spec_helper"

describe SmartyStreetsApi::Decorators::UsFormat do
  let(:office) do
    {
      street: "114 Sansome Street",
      secondary: "Floor 5",
      city: "San Francisco",
      state: "CA",
      zipcode: "94104"
    }
  end
  let(:decorated_office) do
    {
      street: "114 Sansome St",
      secondary: "Fl 5",
      city: "San Francisco",
      state: "CA",
      zipcode: "94104",
      plus4_code: "3812"
    }
  end
  let(:not_found) do
    {
      street: "500 West E Street",
      city: "Butner",
      state: "NC",
      zipcode: "27509"
    }
  end
  let(:with_direction) do
    {
      street: "500 W E Street",
      city: "Butner",
      state: "NC",
      zipcode: "27509"
    }
  end
  let(:decorated_with_direction) do
    {
      street: "500 W E St",
      secondary: nil,
      city: "Butner",
      state: "NC",
      zipcode: "27509",
      plus4_code: "1940"
    }
  end

  it "should decorate correctly a two liner" do
    VCR.use_cassette("us/valid") do
      response = SmartyStreetsApi::UsStreetAddress.get_single(office)

      expect(described_class.new.call(response.first)).to eq(decorated_office)
    end
  end

  it "should not decorate if the address doesn't exist" do
    VCR.use_cassette("us/not_found") do
      response = SmartyStreetsApi::UsStreetAddress.get_single(not_found)

      expect(described_class.new.call(response.first)).to be_nil
    end
  end

  it "should decorate correctly an address including a direction" do
    VCR.use_cassette("us/with_direction") do
      response = SmartyStreetsApi::UsStreetAddress.get_single(with_direction)

      expect(described_class.new.call(response.first)).to eq(decorated_with_direction)
    end
  end
end
