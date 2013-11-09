module Api
  module V1
    class AccountController < ApplicationController

      include Pageable

      def show
        render json: current_user
      end

      def update
        if current_user.update(update_params)
          render json: current_user
        else
          render json: current_user.errors, status: :unprocessable_entity
        end
      end

      def change_password
        if current_user.update_with_password(change_password_params)
          sign_in current_user, :bypass => true
          render json: current_user
        else
          render json: current_user.errors, status: :unprocessable_entity
        end
      end

      def followings
        @followings = Following.of(current_user)
        render json: to_pageable(@followings)
      end

      private

        def update_params
          params.require(:user).permit(:name, :email)
        end

        def change_password_params
          params.require(:user).permit(:current_password, :password, :password_confirmation)
        end

    end
  end
end