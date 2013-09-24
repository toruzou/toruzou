module Api
  module V1
    class UpdatesController < ApplicationController

      include Pageable

      before_action :set_update, only: [:destroy]

      def index
        @updates = Update.all
        if params[:user_id]
          subject_condition = Update.arel_table[:subject_type].eq("User").and(Update.arel_table[:subject_id].eq(params[:user_id]))
          user_condition = Update.arel_table[:user_id].eq(params[:user_id])
          @updates = @updates.where("(#{subject_condition.to_sql}) OR (#{user_condition.to_sql})")
        elsif params[:organization_id].present?
          @updates = @updates.where(:subject_type => "Contact", :subject_id => params[:organization_id])
        elsif params[:person_id].present?
          @updates = @updates.where(:subject_type => "Contact", :subject_id => params[:person_id])
        elsif params[:deal_id].present?
          @updates = @updates.where(:subject_type => "Deal", :subject_id => params[:deal_id])
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
