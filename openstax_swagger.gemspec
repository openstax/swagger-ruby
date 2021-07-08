$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "openstax/swagger/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "openstax_swagger"
  spec.version     = OpenStax::Swagger::VERSION
  spec.authors     = ["JP Slavinsky"]
  spec.email       = ["jpslav@gmail.com"]
  spec.homepage    = "https://github.com/openstax/swagger-ruby"
  spec.summary     = "OpenStax-specific use of swagger-blocks for Ruby projects"
  spec.description = "OpenStax-specific use of swagger-blocks for Ruby projects"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "activesupport"
  spec.add_dependency "swagger-blocks"
  spec.add_dependency "oj"
  spec.add_dependency "oj_mimic_json"

  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rspec"
end
