module Api
  module V1
    class UpdatesController < ApplicationController

      include Pageable

      before_action :set_update, only: [:destroy]

      def index
        @updates = Update.all
        if params[:user_id]
          @updates = @updates.where(:receivable_type => "User", :receivable_id => params[:user_id])
        elsif params[:organization_id].present?
          @updates = @updates.where(:receivable_type => "Contact", :receivable_id => params[:organization_id])
        elsif params[:person_id].present?
          @updates = @updates.where(:receivable_type => "Contact", :receivable_id => params[:person_id])
        elsif params[:deal_id].present?
          @updates = @updates.where(:receivable_type => "Deal", :receivable_id => params[:deal_id])
        end
        render json: to_pageable(@updates)
      end

      def destroy
        @update.destroy
        render json: @update
      end

      private

        def set_update
          @update = Update.find(params[:id])
        end

    end
  end
end
