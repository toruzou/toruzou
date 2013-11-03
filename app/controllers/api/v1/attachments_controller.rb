module Api
  module V1

    class AttachmentsController < ApplicationController

      include Pageable
      include Attachable

      before_action :set_attachment, only: [:show, :edit, :update, :destroy]

      # GET /attachments
      def index
        # TODO refactoring
        @attachments = Attachment.all
        if params[:organization_id].present?
          @attachments = @attachments.where(:attachable_type => "Contact", :attachable_id => params[:organization_id])
        elsif params[:person_id].present?
          @attachments = @attachments.where(:attachable_type => "Contact", :attachable_id => params[:person_id])
        elsif params[:career_id].present?
          @attachments = @attachments.where(:attachable_type => "Career", :attachable_id => params[:career_id])
        elsif params[:deal_id].present?
          @attachments = @attachments.where(:attachable_type => "Deal", :attachable_id => params[:deal_id])
        elsif params[:activity_id].present?
          @attachments = @attachments.where(:attachable_type => "Activity", :attachable_id => params[:activity_id])
        end
        render json: to_pageable(@attachments)
      end

      # GET /attachments/1
      def show
        send_attachment @attachment
      end

      # POST /attachments
      def create
        @attachment = build_attachment attachment_params[:file]
        @attachment.changed_by = current_user
        # TODO refactoring
        @attachment.attachable = Organization.find attachment_params[:organization_id] if attachment_params[:organization_id].present?
        @attachment.attachable = Person.find attachment_params[:person_id] if attachment_params[:person_id].present?
        @attachment.attachable = Career.find attachment_params[:career_id] if attachment_params[:career_id].present?
        @attachment.attachable = Deal.find attachment_params[:deal_id] if attachment_params[:deal_id].present?
        @attachment.attachable = Activity.find attachment_params[:activity_id] if attachment_params[:activity_id].present?
        if @attachment.save
          render json: @attachment
        else
          render json: @attachment, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /attachments/1
      def update
        if @attachment.update(attachment_update_params)
          render json: @attachment
        else
          render json: @attachment.errors ,status: :unprocessable_entity
        end
      end

      # DELETE /attachments/1
      def destroy
        @attachment.changed_by = current_user
        @attachment.destroy
        render json: @attachment
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_attachment
          @attachment = Attachment.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def attachment_params
          params.permit(:file, :organization_id, :person_id, :career_id, :deal_id, :activity_id)
        end

        def attachment_update_params
          params.permit(:comments).merge(:changed_by => current_user)
        end

    end
  end
end
