Rails.application.routes.draw do
  mount OpenStax::Swagger::Engine => "/openstax_swagger"
end
