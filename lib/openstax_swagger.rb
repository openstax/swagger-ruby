require 'active_support'
require "active_support/core_ext"

ActiveSupport::Inflector.inflections do |inflect|
  inflect.acronym 'OpenStax'
end

module OpenStax
  module Swagger

    def self.configure
      yield configuration
    end

    def self.configuration
      @configuration ||= Configuration.new
    end

    class Configuration
      attr_accessor :client_language_configs
      attr_accessor :client_language_post_processing
      attr_accessor :json_proc
      attr_accessor :model_bindings_dir_proc
      attr_accessor :model_bindings_module_proc
      attr_accessor :tmp_dir

      def initialize
        @client_language_configs = {}
        @client_language_post_processing = {}
        @model_bindings_dir_proc = -> (api_major_version) {
          "#{tmp_dir}/api/v#{api_major_version}/bindings"
        }
        @model_bindings_module_proc = -> (api_major_version) {
          "Api::V#{api_major_version}::Bindings"
        }
        @tmp_dir = '/tmp'
      end
    end

  end
end

require "swagger/blocks"
require "openstax/swagger/swagger_blocks_extensions"
require "openstax/swagger/bind"
require "openstax/swagger/generate_model_bindings"
