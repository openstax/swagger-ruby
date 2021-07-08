# OpenStax Swagger

Swagger utilities for OpenStax Ruby projects.  Note that this is a fork of https://github.com/openstax/swagger-rails, without all the Rails dependencies.  This version is good for plain Ruby or Sinatra projects.

## Installation

This gem is not hosted on RubyGems.  Add this line to your application's Gemfile:

```ruby
gem 'openstax_swagger', git: 'https://github.com/openstax/swagger-ruby.git', ref: 'some_shaw'
```

And then execute:
```bash
$ bundle
```

## Docker

You can do everything you need inside a provided Docker container:

```bash
$> ./docker/build
$> ./docker/bash
```

## Generating client libraries

```ruby
OpenStax::Swagger.configure do |config|
  config.client_language_configs = {
    ruby: lambda do |version|
      {
        gemName: 'my_gem_name',
        gemHomepage: 'https://github.com/my_org/my_repo/clients/ruby',
        gemRequiredRubyVersion: '>= 2.4',
        moduleName: "MyModuleName",
        gemVersion: version,
      }
    end,
    javascript: lambda do |version|
      {
        moduleName: "MyModuleName",
        modelPackage: "MyPackage",
        projectName: "MyProject",
        projectVersion: version,
        usePromises: true,
      }
    end
  }
  config.client_language_post_processing = {
    javascript: -> (options) { OpenStax::Swagger::BundleJsClient.bundle(options) }
  }
end
```

## Extensions

### bind

...

### `swagger_path_and_parameters_schema`

`swagger_path_and_parameters_schema` has the same arguments as the native `swagger_path` method but in addition to generating a swagger path definition, it will also call `swagger_schema` on the query parameters to let developers generate a binding from this schema to bind to parameters in a controller call (i.e. they can let swagger-codegen generate code that will validate the incoming parameters instead of replicating validity checks in the schema and in the controller).  Probably only works for simple parameters, not parameters with nested schemas.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
