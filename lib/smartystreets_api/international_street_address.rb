class SmartyStreetsApi::InternationalStreetAddress < SmartyStreetsApi::ApiClient
  def self.whitelisted_input_fields
    %w(
      input_id
      country
      geocode
      language
      freeform
      address1
      address2
      address3
      address4
      organization
      locality
      administrative_area postal_code
    )
  end

  def self.output_address_lines_fields
    %w(
      organization
      address1
      address2
      address3
      address4
      address5
      address6
      address7
      address8
      address9
      address10
      address11
      address12
    )
  end

  def self.output_address_indexes_fields
    %w(input_id)
  end

  def self.endpoint
    "https://international-street.#{SmartyStreetsApi.configuration.base_url}/verify"
  end
end
