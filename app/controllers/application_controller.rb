class ApplicationController < ActionController::Base  
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def to_pageable_collection(collection)
    [ { :total_entries => collection.count }, collection ]
  end

end
