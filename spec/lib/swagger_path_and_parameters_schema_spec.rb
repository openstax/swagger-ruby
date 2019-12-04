require 'rails_helper'

RSpec.describe 'swagger_path_and_parameters_schema' do

  it 'generates the path and parameters definition when there is only one path call' do
    json = Swagger::Blocks.build_root_json([SwaggerPathAndParametersSchema1])

    expect(json[:paths]).to include({
      :"/stembolts" => hash_including({
        get: hash_including({
          summary: "A summary",
          operationId: "getStembolts"
        })
      })
    })

    expect(json[:definitions]).to include({
      "GetStemboltsParameters" => {
        properties: {
          param1: {type: :string},
          param2: {type: :string, description: "Not param1"}
        },
        required: ["param1"]
      }
    })
  end

  it 'works when there are two path calls' do
    json = Swagger::Blocks.build_root_json([SwaggerPathAndParametersSchema2])

    expect(json[:paths]).to include({
      :"/stembolts" => hash_including({
        get: hash_including({
          summary: "A summary",
          operationId: "getStembolts"
        })
      })
    })

    expect(json[:definitions]).to include({
      "GetStemboltsParameters" => {
        properties: {
          param1: {type: :string},
          param2: {type: :string, description: "Not param1"}
        },
        required: ["param1"]
      }
    })
  end

end
