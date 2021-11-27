class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  def redirect_with_error(error_message, redirect_path)
    flash[:error] = error_message
    redirect_to redirect_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :notes])
#   devise_parameter_sanitizer.permit(:registration_update, keys: [:first_name, :last_name, :notes])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :notes])
  end

end
