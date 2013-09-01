module Api
  module V1
    class DealsController < ApplicationController
      before_action :set_deal, only: [:show, :edit, :update, :destroy]

      # GET /deals
      def index
        @deals = Deal.all
      end

      # GET /deals/1
      def show
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
          redirect_to @deal, notice: 'Deal was successfully created.'
        else
          render action: 'new'
        end
      end

      # PATCH/PUT /deals/1
      def update
        if @deal.update(deal_params)
          redirect_to @deal, notice: 'Deal was successfully updated.'
        else
          render action: 'edit'
        end
      end

      # DELETE /deals/1
      def destroy
        @deal.destroy
        redirect_to deals_url, notice: 'Deal was successfully destroyed.'
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_deal
          @deal = Deal.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def deal_params
          params.require(:deal).permit(:pj_type, :organization_id, :counter_person, :pm, :sales, :start_date, :order_date, :accept_date, :amount, :accuracy, :status)
        end
    end
  end
end
