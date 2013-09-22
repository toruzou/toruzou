module Api
  module V1
    class ActivitiesController < ApplicationController

      include Pageable

      before_action :set_activity, only: [:show, :edit, :update, :destroy]

      # GET /activities
      def index
        # TODO refactoring
        @activities = Activity.all
        @activities = @activities.where(:organization_id => params[:organization_id]) if params[:organization_id].present?
        @activities = @activities.where(:deal_id => params[:deal_id]) if params[:deal_id].present?
        @activities = @activities.where("lower(activities.subject) LIKE ?", "%#{params[:subject].downcase}%") if params[:subject].present?
        @activities = @activities.where(action: params[:actions]) if params[:actions].present?
        @activities = @activities.joins(:deal).where("lower(deals.name) LIKE ?", "%#{params[:deal_name].downcase}%") if params[:deal_name].present?
        @activities = @activities.joins(:users).where("users.id" => params[:users_ids]) if params[:users_ids].present?
        @activities = @activities.joins(:people).where("contacts.id" => params[:people_ids]) if params[:people_ids].present?
        @activities = @activities.joins(:organization).where("lower(contacts.name) LIKE ?", "%#{params[:organization_name].downcase}%") if params[:organization_name].present?
        if params[:term].present?
          term = params[:term]
          case term
          when "Overdue" then
            @activities = @activities.where("date < ?", Date.today)
          when "Last Week" then
            @activities = @activities.where(:date => 1.week.ago.beginning_of_week..1.week.ago.end_of_week)
          when "Today" then
            @activities = @activities.where(:date => Date.today)
          when "Tomorrow" then
            @activities = @activities.where(:date => Date.tomorrow)
          when "This Week" then
            @activities = @activities.where(:date => Date.today.beginning_of_week..Date.today.end_of_week)
          when "Next Week" then
            @activities = @activities.where(:date => 1.week.since.beginning_of_week..1.week.since.end_of_week)
          end
        end
        @activities = @activities.where(:done => params[:status]) if params[:status].present?
        render json: to_pageable(@activities, { :order => "done ASC" })
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
