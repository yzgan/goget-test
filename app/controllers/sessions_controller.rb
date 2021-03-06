class SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token
  def create
    user = User.find_by_email(sign_in_params[:email])

    if user&.valid_password?(sign_in_params[:password])
      @current_user = user
      render @current_user
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end
end
