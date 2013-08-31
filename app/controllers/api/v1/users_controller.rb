module Api
  module V1
    class UsersController < ApplicationController

      def index
        # FIXME Should refactor
        @users = params[:q] ? User.where("lower(username) LIKE ?", "%#{params[:q].downcase}%") : User.all
        if params[:page]
          @users = @users.page(params[:page])
          @users = @users.per(params[:per_page]) if params[:per_page]
          if params[:sort_by]
            sorting = params[:sort_by]
            sorting = "#{sorting} #{order}" if params[:order]
            @users = @users.order sorting
          end
        end
        render json: to_pageable_collection(@users)
      end

    end
  end
end