module Api
  module V1
    class NotificationsController < ApplicationController

      include Pageable

      def index
        @notifications = Notification.match_receivable("User", current_user)
        render json: to_pageable(@notifications)
      end

    end
  end
end
