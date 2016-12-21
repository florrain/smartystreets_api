module SmartyStreetsApi::Exceptions
  class SevereApiError < StandardError
    def initialize(message)
      super
    end
  end
end
