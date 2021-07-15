class ApiController < ActionController::API
  respond_to :json

  private

  def authenticate_user
    if request.headers['Authorization'].present?
      begin
        jwt_payload = JWT.decode(http_token, Rails.application.secrets.secret_key_base).first
        current_user_id = jwt_payload['id']
        return head :unauthorized unless current_user_id.present?

        @current_user = User.find_by(id: current_user_id)
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        head :unauthorized
      end
    else
      head :unauthorized
    end
  end

  def http_token
    if request.headers['Authorization'].present?
      request.headers['Authorization'].split(' ').last
    end
  end

  def render_jsonapi_response(resource)
    if resource.errors.empty?
      render resource
    else
      render json: { errors: resource.errors }, status: :unprocessable_entity
    end
  end

  def render_error_message(message)
    render json: { error: message }, status: :unprocessable_entity
  end
end
