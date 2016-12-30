class SmartyStreetsApi::Decorators::InternationalFormat2Lines < SmartyStreetsApi::Decorators::BaseDecorator
  def call(address_object)
    return unless (decorated_address = super)

    decorated_address[:organization] = address_object[:lines][:organization]

    unless decorated_address[:address1]
      decorated_address[:address1] = decorated_address[:address_1_alternative]
      decorated_address[:address2] = decorated_address[:address_2_alternative]
    end

    decorated_address.delete(:address_1_alternative)
    decorated_address.delete(:address_2_alternative)

    decorated_address
  end

  private

  def organization
    [:organization]
  end

  def address1
    [:building]
  end

  def address_1_alternative
    [
      :premise,
      :thoroughfare
    ]
  end

  def address2
    [
      :premise,
      :thoroughfare,
      :sub_building_name,
      :sub_building_type,
      :sub_building_number,
      :post_box
    ]
  end

  def address_2_alternative
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
