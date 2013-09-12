module Api
  module V1
    class UsersController < ApplicationController

      include Pageable

      def index
        @users = params[:name] ? User.where("lower(name) LIKE ?", "%#{params[:name].downcase}%") : User.all
        render json: to_pageable(@users)
      end

    end
  end
end