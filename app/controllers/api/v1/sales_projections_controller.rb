module Api
  module V1

    class SalesProjectionsController < ApplicationController

      include Pageable

      before_action :set_sales_projection, only: [ :show ]
      before_action :set_sales_projection_for_update, only: [ :edit, :update, :destroy ]

      # GET /sales_projections
      def index
        @sales_projections = SalesProjection.all
        @sales_projections = @sales_projections.of(params[:deal_id]) if params[:deal_id].present?
        @sales_projections = @sales_projections.match_deal(params[:deal_name]) if params[:deal_name].present?
        @sales_projections = @sales_projections.match_project_types(params[:project_types]) if params[:project_types].present?
        @sales_projections = @sales_projections.match_categories(params[:categories]) if params[:categories].present?
        @sales_projections = @sales_projections.match_statuses(params[:statuses]) if params[:statuses].present?
        @sales_projections = @sales_projections.match_organization(params[:organization_name]) if params[:organization_name].present?
        @sales_projections = @sales_projections.year_from(params[:from]) if params[:from].present?
        @sales_projections = @sales_projections.year_to(params[:to]) if params[:to].present?
        render json: to_pageable(@sales_projections)
      end

      def to_order_key(key)
        if key == "organization"
          return "deals.organization_id"
        else
          super key
        end
      end

      # GET /sales_projections/1
      def show
        render json: @sales_projection
      end

      # GET /sales_projections/new
      def new
        @sales_projection = SalesProjection.new
      end

      # GET /sales_projections/1/edit
      def edit
      end

      # POST /sales_projections
      def create
        @sales_projection = SalesProjection.new(sales_projection_update_params)
        if @sales_projection.save
          render json: @sales_projection
        else
          render json: @sales_projection.errors ,status: :unprocessable_entity
        end
      end

      # PATCH/PUT /sales_projections/1
      def update
        if @sales_projection.update(sales_projection_update_params)
          render json: @sales_projection
        else
          render json: @sales_projection.errors ,status: :unprocessable_entity
        end
      end

      # DELETE /sales_projections/1
      def destroy
        @sales_projection.changed_by = current_user
        @sales_projection.destroy
        render json: @sales_projection
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_sales_projection
          @sales_projection = SalesProjection.find(params[:id])
        end

        def set_sales_projection_for_update
          @sales_projection = SalesProjection.unscoped.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def sales_projection_update_params
          params.require(:sales_projection).permit(:year, :period, :amount, :remarks, :deal_id).merge(:changed_by => current_user)
        end

    end
  end
end
