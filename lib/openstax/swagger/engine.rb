ActiveSupport::Inflector.inflections do |inflect|
  inflect.acronym 'OpenStax'
end

module OpenStax
  module Swagger
    class Engine < ::Rails::Engine
      isolate_namespace OpenStax::Swagger

      config.generators do |g|
        g.test_framework :rspec
      end
    end
  end
end
