OpenStax::Swagger.configure do |config|
  config.json_proc = -> (api_major_version) {
    Swagger::Blocks.build_root_json(
      [
        SchemaOne
      ]
    )
  }
  config.model_bindings_dir_proc = -> (api_major_version) {
    "#{Rails.application.root}/app/bindings/api/v#{api_major_version}/bindings"
  }
  config.model_bindings_module_proc = -> (api_major_version) {
    "Api::V#{api_major_version}::Bindings"
  }
end
