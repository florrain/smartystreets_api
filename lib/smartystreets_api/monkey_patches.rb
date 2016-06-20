module SmartyStreetsApi
  module MonkeyPatches
    module Hash

      def symbolize_keys!
        keys.each do |key|
          self[key.to_sym] = delete(key)
        end
        self
      end unless method_defined?(:symbolize_keys!)

    end
  end
end

Hash.send(:include, SmartyStreetsApi::MonkeyPatches::Hash)
