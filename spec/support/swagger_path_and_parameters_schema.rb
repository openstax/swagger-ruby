module SwaggerPathAndParametersSchema
  include Swagger::Blocks
  include OpenStax::Swagger::SwaggerBlocksExtensions

  swagger_root do
    key :swagger, '2.0'
  end

  swagger_path_and_parameters_schema '/stembolts' do
    operation :get do
      key :summary, 'A summary'
      key :operationId, 'getStembolts'
      key :produces, [
        'application/json'
      ]
      key :tags, [
        'Stembolts'
      ]
      parameter do
        key :name, :param1
        key :in, :query
        key :type, :string
        key :required, true
      end
      parameter do
        key :name, :param2
        key :in, :query
        key :type, :string
        key :required, false
        key :description, 'Not param1'
      end
      response 200 do
        key :description, 'Success.'
      end
    end
  end
end
