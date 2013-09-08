module Api
  module V1
    class UsersController < ApplicationController

      include Pageable

      def index
        @users = params[:username] ? User.where("lower(username) LIKE ?", "%#{params[:username].downcase}%") : User.all
        render json: to_pageable(@users)
      end

    end
  end
end