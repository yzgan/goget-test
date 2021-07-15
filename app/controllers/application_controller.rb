class ApplicationController < ActionController::Base

  private

  def render_jsonapi_response(resource)
    if resource.errors.empty?
      render resource
    else
      render json: { errors: resource.errors }, status: :unprocessable_entity
    end
  end
end
