class SmartyStreetsApi::Decorators::UsFormat < SmartyStreetsApi::Decorators::BaseDecorator
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
