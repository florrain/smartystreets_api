class SmartyStreetsApi::UsStreetAddress < SmartyStreetsApi::ApiClient
  INPUTS = %w(input_id street street2 secondary city state zipcode lastline addressee urbanization candidates)
  OUTPUT_ADDRESS_LINES = %w(addressee delivery_line_1 delivery_line_2 last_line)
  OUTPUT_ADDRESS_INDEXES = %w(input_id input_index candidate_index delivery_point_barcode)

  def self.get_single(options)
    uri = URI("#{host}/street-address")

    args = options.select { |name, value| INPUTS.include?(name.to_s) && (value && !value.empty?) }.merge!(auth_args)

    uri.query = URI.encode_www_form(args)

    response = Net::HTTP.get_response(uri)

    raise_error!(response.code) if severe_error?(response.code)

    parse(response)
  end

  private

  def self.parse(response)
    json_response = JSON.parse(response.body)

    parse_response(json_response)
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

  def self.severe_error?(response_status_code)
    response_status_code.to_i != 200
  end

  def self.raise_error!(response_status_code)
    reason = case response_status_code.to_i
    when 401
      "Unauthorized"
    when 402
      "Payment Required"
    when 413
      "Request Entity Too Large"
    when 400
      "Bad Request (Malformed Payload)"
    when 429
      "Too Many Requests"
    else
      "Unknown error: #{response_status_code}"
    end

    raise SmartyStreetsApi::Exceptions::SevereApiError.new(reason)
  end

  def self.host
    "https://#{SmartyStreetsApi.configuration.base_url}"
  end
end
