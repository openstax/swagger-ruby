require_relative 'swagger_codegen'

module OpenStax::Swagger
  module GenerateClient

    def self.generate(api_major_version: '1', language:, configuration: OpenStax::Swagger.configuration)
      language = language.to_sym
      raise "Must specify a language, e.g. ruby" if language.nil?
      output_dir = nil

      OpenStax::Swagger::SwaggerCodegen.execute(api_major_version: api_major_version, configuration: configuration) do |json|
        api_exact_version = json[:info][:version]
        output_dir = "#{configuration.tmp_dir}/clients/#{api_exact_version}/#{language}"

        config = configuration.client_language_configs[language]
        raise "Don't know #{language} config options yet, see `swagger-codegen config-help -l #{language}" unless config

        # Clean out anything that use to be there so old bindings do come back to life
        FileUtils.rm_rf(output_dir)

        {
          cmd_options: %W[-l #{language}],
          output_dir: output_dir,
          config: config.call(api_exact_version),
          post_process: configuration.client_language_post_processing[language]
        }
      end

    end

  end
end
