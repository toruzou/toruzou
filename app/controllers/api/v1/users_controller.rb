module Api
  module V1
    class UsersController < ApplicationController

      include Pageable

      before_action :set_user, only: [:show, :followings, :follow, :unfollow]

      def index
        @users = User.all
        @users = @users.where("lower(name) LIKE ?", "%#{params[:name].downcase}%") if params[:name]
        @users = @users.where("lower(email) LIKE ?", "%#{params[:email].downcase}%") if params[:email]
        render json: to_pageable(@users)
      end

      def show
        render json: @user
      end

      def followings
        @followings = Following.of(@user)
        render json: to_pageable(@followings)
      end

      def follow
        @user.follow_by(current_user)
        render json: @user
      end

      def unfollow
        @user.unfollow_by(current_user)
        render json: @user
      end

      private

        def set_user
          @user = User.find(params[:id])
        end

    end
  end
end