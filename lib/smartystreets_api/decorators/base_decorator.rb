class SmartyStreetsApi::Decorators::BaseDecorator
  def call(address_object)
    return if !address_object || !address_object[:components]

    decorated_components = self.class.private_instance_methods(false).inject({}) do |decorated_address, attribute|
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

    remove_empty_address_lines!(decorated_components)

    decorated_components
  end
end
