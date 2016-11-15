class SmartyStreetsApi::InternationalStreetAddress < SmartyStreetsApi::ApiClient
  INPUTS = %w(input_id country geocode language freeform address1 address2 address3 address4 organization locality administrative_area postal_code)
  OUTPUT_ADDRESS_LINES = %w(organization address1 address2 address3 address4 address5 address6 address7 address8 address9 address10 address11 address12)
  OUTPUT_ADDRESS_INDEXES = %w(input_id)

  def self.get_single(options)
    uri = URI("#{host}/verify")

    args = options.select { |name, value| INPUTS.include?(name.to_s) && (value && !value.empty?) }.merge!(auth_args)

    uri.query = URI.encode_www_form(args)

    response = Net::HTTP.get_response(uri)

    parse(response)
  end

  private

  def self.parse(response)
    parsed_response = JSON.parse(response.body)

    raise_error!(parsed_response) if severe_error?(response.code)

    parse_response(parsed_response)
  end

  def self.parse_response(response)
    response.map do |address|
      {
        lines: address_lines(address).symbolize_keys!,
        indexes: address_indexes(address).symbolize_keys!,
        components: address["components"].symbolize_keys!,
        metadata: address["metadata"].symbolize_keys!,
        analysis: address["analysis"].symbolize_keys!
      }
    end
  end

  def self.address_lines(address)
    address.select { |field| OUTPUT_ADDRESS_LINES.include?(field) }.symbolize_keys!
  end

  def self.address_indexes(address)
    address.select { |field| OUTPUT_ADDRESS_INDEXES.include?(field) }.symbolize_keys!
  end

  def self.host
    "https://international-street.#{SmartyStreetsApi.configuration.base_url}"
  end
end
