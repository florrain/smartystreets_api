class SmartyStreetsApi::Decorators::UsFormat
  def call(address_object)
    return if !address_object || !address_object[:components]

    self.class.private_instance_methods(false).inject({}) do |decorated_address, attribute|
      components = self.send(attribute.to_sym)

      array_values = components.map do |component_name|
        if address_object[:components] && address_object[:components][component_name]
          address_object[:components][component_name]
        else
          nil
        end
      end.compact

      decorated_address[attribute] = array_values.empty? ? nil : array_values.join(" ")

      decorated_address
    end
  end

  private

  def street
    [
      :primary_number,
      :street_predirection,
      :street_name,
      :street_postdirection,
      :street_suffix
    ]
  end

  def secondary
    [
      :secondary_designator,
      :secondary_number,
      :extra_secondary_designator,
      :extra_secondary_number
    ]
  end

  def city
    [:city_name]
  end

  def state
    [:state_abbreviation]
  end

  def zipcode
    [:zipcode]
  end

  def plus4_code
    [:plus4_code]
  end
end
