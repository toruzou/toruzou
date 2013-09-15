module Api
  module V1
    class ActivitiesController < ApplicationController

      include Pageable

      before_action :set_activity, only: [:show, :edit, :update, :destroy]

      # GET /activities
      def index
        # TODO apply filtering conditions
        @activities = Activity.all
        render json: to_pageable(@activities)
      end

      # GET /activities/1
      def show
        render json: @activity
      end

      # GET /activities/new
      def new
        @activity = Activity.new
      end

      # GET /activities/1/edit
      def edit
      end

      # POST /activities
      def create
        @activity = Activity.new(activity_params)
        @activity.users = User.find(users_params[:users_ids] ||= [])
        @activity.people = Person.find(people_params[:people_ids] ||= [])
        if @activity.save
          render json: @activity
        else
          render json: @activity, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /activities/1
      def update
        @activity.assign_attributes(activity_params)
        @activity.users.clear
        @activity.users = User.find(users_params[:users_ids] ||= [])
        @activity.people.clear
        @activity.people = Person.find(people_params[:people_ids] ||= [])
        if @activity.save
          render json: @activity
        else
          render json: @activity, status: :unprocessable_entity
        end
      end

      # DELETE /activities/1
      def destroy
        @activity.destroy
        render json: @activity
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_activity
          @activity = Activity.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def activity_params
          params.require(:activity).permit(
            :subject,
            :action,
            :date,
            :note,
            :done,
            :organization_id,
            :deal_id
          )
        end

        def users_params
          params.require(:activity).permit(:users_ids => [])
        end

        def people_params
          params.require(:activity).permit(:people_ids => [])
        end

    end
  end
end
