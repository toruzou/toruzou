class ApplicationController < ActionController::Base  

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def to_pageable_collection(collection)
    [ { :total_entries => collection.count }, collection ]
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password ) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login) }
  end

end
