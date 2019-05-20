require "openstax/swagger/engine"

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

      def initialize
        @client_language_configs = {}
        @client_language_post_processing = {}
      end
    end

  end
end

require "swagger/blocks"
require "openstax/swagger/swagger_blocks_extensions"
require "openstax/swagger/bind"
