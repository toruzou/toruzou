module Api
  module V1

    class CareersController < ApplicationController

      include Pageable

      before_action :set_career, only: [:show, :edit, :update, :destroy]

      # GET /careers
      def index
        @careers = Career.all
        @careers = @careers.where(:person_id => params[:person_id]) if params[:person_id].present?
        render json: to_pageable(@careers)
      end

      # GET /careers/1
      def show
        render json: @career
      end

      # GET /careers/new
      def new
        @career = Career.new
      end

      # GET /careers/1/edit
      def edit
      end

      # POST /careers
      def create
        @career = Career.new(career_update_params)
        if @career.save
          render json: @career
        else
          render json: @career.errors ,status: :unprocessable_entity
        end
      end

      # PATCH/PUT /careers/1
      def update
        if @career.update(career_update_params)
          render json: @career
        else
          render json: @career.errors ,status: :unprocessable_entity
        end
      end

      # DELETE /careers/1
      def destroy
        @carrer.changed_by = current_user
        @career.destroy
        render json: @career
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_career
          @career = Career.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def career_update_params
          params.require(:career).permit(:from_date, :to_date, :department, :title, :remarks, :person_id).merge(:changed_by => current_user)
        end

    end
  end
end
