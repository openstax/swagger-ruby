require 'byebug'

class SchemaOne
  include Swagger::Blocks
  include OpenStax::Swagger::SwaggerBlocksExtensions

  ACCEPT_HEADER = 'application/json'
  BASE_PATH = '/api/v0'

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '0.1.0'
      key :title, 'A Title'
      key :termsOfService, 'https://example.com/tos'
      contact do
        key :name, 'support@example.com'
      end
      license do
        key :name, 'MIT'
      end
    end
    key :basePath, BASE_PATH
    key :consumes, [ACCEPT_HEADER]
    key :produces, ['application/json']
  end

  swagger_schema :AnArrayItem do
    key :required, [:a_string]
    property :a_string do
      key :type, :string
    end
  end

  swagger_schema :TopLevel do
    key :required, [:an_integer]
    property :an_integer do
      key :type, :integer
      key :readOnly, true
      key :description, "Something"
    end
    property :an_arbitrary_object do
      key :type, :object
      key :readOnly, true
    end
    property :a_defined_object do
      key :required, [:another_integer]
      property :another_integer do
        key :type, :integer
        key :readOnly, true
      end
      property :an_array do
        key :type, :array
        key :description, "An array"
        items do
          key :'$ref', :AnArrayItem
        end
      end
    end
  end

end
