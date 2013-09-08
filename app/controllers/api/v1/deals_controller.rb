module Api
  module V1
    class DealsController < ApplicationController

      include Pageable

      before_action :set_deal, only: [:show, :edit, :update, :destroy]

      # GET /deals
      def index
        @deals = Deal.all
        render json: to_pageable(@deals)
      end

      # GET /deals/1
      def show
        render json: @deal
      end

      # GET /deals/new
      def new
        @deal = Deal.new
      end

      # GET /deals/1/edit
      def edit
      end

      # POST /deals
      def create
        @deal = Deal.new(deal_params)
        if @deal.save
          render json: @deal
        else
          render json: @deal, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /deals/1
      def update
        if @deal.update(deal_params)
          render json: @deal
        else
          render json: @deal, status: :unprocessable_entity
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
          params.require(:deal).permit(:name, :organization_id, :start_date, :order_date, :accept_date, :amount, :accuracy, :status)
        end
    end
  end
end
