module Api
  module V1
    class DealsController < ApplicationController

      include Pageable

      before_action :set_deal, only: [:show, :edit, :update, :destroy]

      # GET /deals
      def index
        # FIXME ugly, does anyone know how to alias the joined table on Rails ?
        @deals = Deal.all

        @deals = @deals.match_user(params[:user_id]) if params[:user_id].present?
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
        @deal = Deal.new(deal_params)
        if @deal.save
          render json: @deal
        else
          render json: @deal.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /deals/1
      def update
        if @deal.update(deal_params)
          render json: @deal
        else
          render json: @deal.errors, status: :unprocessable_entity
        end
      end

      # DELETE /deals/1
      def destroy
        @deal.destroy
        render json: @deal
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_deal
          @deal = Deal.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def deal_params
          params.require(:deal).permit(
            :name,
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
          )
        end
    end
  end
end
