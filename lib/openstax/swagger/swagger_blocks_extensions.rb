module OpenStax::Swagger::SwaggerBlocksExtensions

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def add_properties(*schema_names, &block)
      schema_names.each do |schema_name|
        swagger_schema schema_name do
          instance_eval(&block)
        end
      end
    end

    # Same as call to `swagger_path` but also generates a `swagger_model` for the parameters
    # so that controller code can bind the parameters to a binding.
    def swagger_path_and_parameters_model(path, &block)
      swagger_path(path, &block).tap do |path_node|
        if path_node.data[:operationId].blank?
          raise "Must set an operationId when generating a binding from a swagger_path"
        end

        binding_name = path_node.data[:operationId].camelcase
        required_keys = []

        swagger_schema binding_name do
          path_node.data[:parameters].map(&:data).each do |parameter_hash|
            parameter_hash.symbolize_keys!
            required_keys.push(parameter_hash[:name]) if parameter_hash.delete(:required)
            property parameter_hash[:name] do
              parameter_hash.except(:in, :name).each do |key, value|
                key key, value
              end
            end
          end
          key :required, required_keys
        end
      end
    end
  end

end
