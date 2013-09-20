module Api
  module V1
    class DealsController < ApplicationController

      include Pageable

      before_action :set_deal, only: [:show, :edit, :update, :destroy]

      # GET /deals
      def index
        # FIXME ugly, does anyone know how to alias the joined table on Rails ?
        @deals = Deal.all
        if params[:user_id]
          condition = Deal.arel_table[:pm_id].eq(params[:user_id])
          condition = condition.or(Deal.arel_table[:sales_id].eq(params[:user_id]))
          @deals = @deals.where(condition)
        end
        @deals = @deals.where(:organization_id => params[:organization_id]) if params[:organization_id].present?
        @deals = @deals.where(:contact_id => params[:person_id]) if params[:person_id].present?
        @deals = @deals.where("lower(deals.name) LIKE ?", "%#{params[:name].downcase}%") if params[:name].present?
        @deals = @deals.joins(%(INNER JOIN "contacts" as "organization" ON "organization"."id" = "deals"."organization_id" AND "organization"."type" IN ('Organization'))).where("lower(organization.name) LIKE ?", "%#{params[:organization_name].downcase}%") if params[:organization_name].present?
        @deals = @deals.joins(%(INNER JOIN "contacts" as "contact" ON "contact"."id" = "deals"."contact_id" AND "contact"."type" IN ('Person'))).where("lower(contact.name) LIKE ?", "%#{params[:contact_name].downcase}%") if params[:contact_name].present?
        @deals = @deals.joins(%(INNER JOIN "users" as "pm" ON "pm"."id" = "deals"."pm_id")).where("lower(pm.name) LIKE ?", "%#{params[:pm_name].downcase}%") if params[:pm_name].present?
        @deals = @deals.joins(%(INNER JOIN "users" as "sales" ON "sales"."id" = "deals"."sales_id")).where("lower(sales.name) LIKE ?", "%#{params[:sales_name].downcase}%") if params[:sales_name].present?
        @deals = @deals.where(status: params[:statuses]) if params[:statuses].present?
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
