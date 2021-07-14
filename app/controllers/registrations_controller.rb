class RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, only: %i[create]

  def create
    build_resource(sign_up_params)
    resource.save
    sign_up(resource_name, resource) if resource.persisted?
    render_jsonapi_response(resource)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
