module Api
  module V1
    class ActivitiesController < ApplicationController

      include Pageable

      before_action :set_activity, only: [:show, :edit, :update, :destroy]

      # GET /activities
      def index
        if params[:include_deleted].present? and params[:include_deleted] == "true"
          @activities = Activity.with_deleted
        else
          @activities = Activity.all
        end
        @activities = @activities.in_organization(params[:organization_id]) if params[:organization_id].present?
        @activities = @activities.in_deal(params[:deal_id]) if params[:deal_id].present?
        @activities = @activities.match_subject(params[:subject]) if params[:subject].present?
        @activities = @activities.in_actions(params[:actions]) if params[:actions].present?
        @activities = @activities.match_deal(params[:deal_name]) if params[:deal_name].present?
        @activities = @activities.with_users(params[:users_ids]) if params[:users_ids].present?
        @activities = @activities.with_people(params[:people_ids]) if params[:people_ids].present?
        @activities = @activities.match_organization(params[:organization_name]) if params[:organization_name].present?
        @activities = @activities.date_is(params[:term]) if params[:term].present?
        @activities = @activities.is_done(params[:status]) if params[:status].present?
        render json: to_pageable(@activities, { :order => "done ASC" })
      end

      # GET /activities/1
      def show
        render json: @activity
      end

      # POST /activities
      def create
        @activity = Activity.new(activity_params)
        @activity.users = User.find(users_params[:users_ids] ||= [])
        @activity.people = Person.find(people_params[:people_ids] ||= [])
        if @activity.save
          render json: @activity
        else
          render json: @activity.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /activities/1
      def update
        if params[:restore].present? and params[:restore] == "true"
          @activity.restore!
          render json: @activity
        else
          @activity.assign_attributes(activity_params)
          @activity.users.clear
          @activity.users = User.find(users_params[:users_ids] ||= [])
          @activity.people.clear
          @activity.people = Person.find(people_params[:people_ids] ||= [])
          if @activity.save
            render json: @activity
          else
            render json: @activity.errors, status: :unprocessable_entity
          end
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
          @activity = Activity.with_deleted.find(params[:id])
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
