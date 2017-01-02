class SmartyStreetsApi::ApiClient
  def self.get_single(options)
    uri = URI(endpoint)

    args = options.select do |name, value|
      whitelisted_input_fields.include?(name.to_s)
    end.merge!(auth_args)

    uri.query = URI.encode_www_form(args)

    response = Net::HTTP.get_response(uri)

    raise_error!(response.code) if severe_error?(response.code)

    parse(response)
  end

  private

  def self.parse(response)
    parsed_response = JSON.parse(response.body)

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
    address.select { |field| output_address_lines_fields.include?(field) }.symbolize_keys!
  end

  def self.address_indexes(address)
    address.select { |field| output_address_indexes_fields.include?(field) }.symbolize_keys!
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

  def self.auth_args
    SmartyStreetsApi.configuration.auth_args
  end
end
