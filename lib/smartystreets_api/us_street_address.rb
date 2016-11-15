class SmartyStreetsApi::UsStreetAddress < SmartyStreetsApi::ApiClient
  def self.whitelisted_input_fields
    %w(
      input_id
      street
      street2
      secondary
      city
      state
      zipcode
      lastline
      addressee
      urbanization
      candidates
    )
  end

  def self.output_address_lines_fields
    %w(
      addressee
      delivery_line_1
      delivery_line_2
      last_line
    )
  end

  def self.output_address_indexes_fields
    %w(
      input_id
      input_index
      candidate_index
      delivery_point_barcode
    )
  end

  def self.endpoint
    "https://#{SmartyStreetsApi.configuration.base_url}/street-address"
  end
end
