class ApplicationController < ActionController::API
 #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name photo bio email password password_confirmation])
  end

  def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    if header
      header = header.split.last

      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find_by_id!(@decoded[:user_id])
      rescue ActiveRecord::RecordNotFound || JWT::DecodeError => e
        render json: { error: e.message }, status: :unauthorized
      end
    else
      render json: { error: 'Unauthorized User' }, status: :unauthorized
    end
  end

  private

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end
end
