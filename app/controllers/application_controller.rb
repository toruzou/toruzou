class ApplicationController < ActionController::Base  

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  serialization_scope :view_context

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_devise_parameters, if: :devise_controller?

  protected

  def configure_devise_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password) }
  end

  private
  
  def not_found
    head :not_found
  end
end
