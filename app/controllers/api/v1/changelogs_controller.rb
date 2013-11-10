module Api
  module V1
    class ChangelogsController < ApplicationController

      include Pageable

      def index
        @changelogs = Changelog.all
        @changelogs = @changelogs.match_receivable("User", params[:user_id]) if params[:user_id].present?
        @changelogs = @changelogs.match_receivable("Contact", params[:organization_id]) if params[:organization_id].present?
        @changelogs = @changelogs.match_receivable("Contact", params[:person_id]) if params[:person_id].present?
        @changelogs = @changelogs.match_receivable("Deal", params[:deal_id]) if params[:deal_id].present?
        @changelogs = @changelogs.match_receivable("Activity", params[:activity_id]) if params[:activity_id].present?
        render json: to_pageable(@changelogs)
      end

    end
  end
end
