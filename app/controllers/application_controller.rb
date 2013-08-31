class ApplicationController < ActionController::Base  

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_devise_parameters, if: :devise_controller?

  protected

  def configure_devise_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password) }
  end

end
