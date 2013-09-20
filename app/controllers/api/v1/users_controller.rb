module Api
  module V1
    class UsersController < ApplicationController

      include Pageable

      before_action :set_deal, only: [:show]

      def index
        @users = User.all
        @users = @users.where("lower(name) LIKE ?", "%#{params[:name].downcase}%") if params[:name]
        @users = @users.where("lower(email) LIKE ?", "%#{params[:email].downcase}%") if params[:email]
        render json: to_pageable(@users)
      end

      def show
        render json: @user
      end

      private

        def set_deal
          @user = User.find(params[:id])
        end

    end
  end
end