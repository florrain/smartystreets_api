class SmartyStreetsApi::Decorators::InternationalFormat < SmartyStreetsApi::Decorators::BaseDecorator
  def call(address_object)
    return unless (decorated_address = super)

    decorated_address[:organization] = address_object[:lines][:organization]

    decorated_address
  end

  def remove_empty_address_lines!(decorated_address)
    unless decorated_address[:address2]
      decorated_address[:address2] = decorated_address[:address3]
      decorated_address[:address3] = nil
    end

    unless decorated_address[:address1]
      decorated_address[:address1] = decorated_address[:address2]
      decorated_address[:address2] = decorated_address[:address3]
      decorated_address[:address3] = nil
    end
  end

  private

  def organization
    [:organization]
  end

  def address1
    [:building]
  end

  def address2
    [
      :premise,
      :thoroughfare
    ]
  end

  def address3
    [
      :sub_building_name,
      :sub_building_type,
      :sub_building_number,
      :post_box
    ]
  end

  def locality
    [:locality]
  end

  def postal_code
    [:postal_code_short]
  end

  def administrative_area
    [:administrative_area]
  end

  def country
    [:country_iso_3]
  end
end
