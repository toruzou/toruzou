module Api
  module V1
    class DealsController < ApplicationController

      include Pageable

      before_action :set_deal, only: [:show, :edit, :update, :destroy, :follow, :unfollow]

      # GET /deals
      def index
        # FIXME ugly, does anyone know how to alias the joined table on Rails ?
        if params[:include_deleted].present? and params[:include_deleted] == "true"
          @deals = Deal.with_deleted
        else
          @deals = Deal.all
        end
        @deals = @deals.match_user(params[:user_id]) if params[:user_id].present?
        @deals = @deals.match_category(params[:categories]) if params[:categories].present?
        @deals = @deals.in_organization(params[:organization_id]) if params[:organization_id].present?
        @deals = @deals.where(:contact_id => params[:person_id]) if params[:person_id].present?
        @deals = @deals.match_name(params[:name]) if params[:name].present?
        @deals = @deals.match_organization(params[:organization_name]) if params[:organization_name].present?
        @deals = @deals.match_contact(params[:contact_name]) if params[:contact_name].present?
        @deals = @deals.match_pm(params[:pm_name]) if params[:pm_name].present?
        @deals = @deals.match_sales(params[:sales_name]) if params[:sales_name].present?
        @deals = @deals.match_status(params[:statuses]) if params[:statuses].present?
        render json: to_pageable(@deals)
      end

      # GET /deals/1
      def show
        render json: @deal
      end

      # POST /deals
      def create
        @deal = Deal.new(deal_update_params)
        if @deal.save
          render json: @deal
        else
          render json: @deal.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /deals/1
      def update
        if params[:restore].present? and params[:restore] == "true"
          @deal.restore!
          render json: @deal
        else
          if @deal.update(deal_update_params)
            render json: @deal
          else
            render json: @deal.errors, status: :unprocessable_entity
          end
        end
      end

      # DELETE /deals/1
      def destroy
        @deal.changed_by = current_user
        @deal.destroy
        render json: @deal
      end

      def follow
        @deal.follow_by(current_user)
        render json: @deal
      end

      def unfollow
        @deal.unfollow_by(current_user)
        render json: @deal
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_deal
          @deal = Deal.with_deleted.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def deal_update_params
          params.require(:deal).permit(
            :name,
            :category,
            :organization_id,
            :contact_id,
            :pm_id,
            :sales_id,
            :start_date,
            :order_date,
            :accept_date,
            :amount,
            :accuracy,
            :status
          ).merge(:changed_by => current_user)
        end
    end
  end
end
