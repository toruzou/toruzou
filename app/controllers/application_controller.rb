class ApplicationController < ActionController::Base  

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_devise_parameters, if: :devise_controller?

  protected

  def to_pageable_collection(collection)
    [ { :total_entries => collection.count }, collection ]
  end

  def configure_devise_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :password) }
  end

  def escape_like(s)
    s.gsub(/\\/, "\\\\").gsub(/%/, "\\%").gsub(/_/, "\\_")
  end

end
