module Api
  module V1
    class UsersController < ApplicationController

      include Pageable

      def index
        @users = params[:q] ? User.where("lower(username) LIKE ?", "%#{params[:q].downcase}%") : User.all
        render json: to_pageable(@users)
      end

    end
  end
end