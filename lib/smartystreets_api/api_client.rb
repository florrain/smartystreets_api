class SmartyStreetsApi::ApiClient
  def self.severe_error?(response_status_code)
    response_status_code.to_i != 200
  end

  def self.raise_error!(response_status_code)
    case response_status_code
    when 401
      raise "SmartyStreets - Unauthorized"
    when 402
      raise "SmartyStreets - Payment Required"
    when 413
      raise "SmartyStreets - Request Entity Too Large"
    when 400
      raise "SmartyStreets - Bad Request (Malformed Payload)"
    when 429
      raise "SmartyStreets - Too Many Requests"
    else
      raise "SmartyStreets - Unknown error"
    end
  end

  def self.auth_args
    SmartyStreetsApi.configuration.auth_args
  end
end
