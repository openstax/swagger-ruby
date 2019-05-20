module OpenStax::Swagger
  module Bind

    protected

    def bind(data, bindings_class)
      begin
        # Some swagger types are simple scalars and some are arrays or other
        # For arrays, when we call permit, we need to call it with `:key_name => []`
        # Use the `swagger_types` data in the bindings class to find those cases
        # and generate the correct arguments to pass to `permit`.

        data_hash = data.permit(bindings_class.swagger_types.map { |k,v|
          v.to_s.starts_with?("Array") ? {k => []} : k
        }).to_h

        binding = bindings_class.new(data_hash)

        # do some simple extra error checking
        keys_in_binding = binding.to_body.keys.map(&:to_s)
        keys_in_data = data.keys.map(&:to_s)

        unused_keys = keys_in_data - keys_in_binding
        bad_keys = unused_keys & bindings_class.swagger_types.keys.map(&:to_s)
        unrequested_keys = unused_keys - bad_keys

        if bad_keys.any?
          # NB: Some other things can generate ArgumentError besides this
          raise ArgumentError, "Some keys caused errors: #{bad_keys}"
        end
      rescue ArgumentError => ee
        return [nil, binding_error(status_code: 422, messages: [ee.message])]
      end

      return [binding, nil] if binding.valid?

      [binding, binding_error(status_code: 422, messages: binding.list_invalid_properties)]
    end

    def binding_error(status_code:, messages:)
      raise "Implement a `binding_error(status_code:, messages:)` method in your " \
            "controller that returns a new object that can be serialized to JSON and " \
            "that has a `status_code` accessor"
    end

  end
end
