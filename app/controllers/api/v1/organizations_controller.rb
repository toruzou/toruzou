module Api
  module V1

    class OrganizationsController < ApplicationController

      include Pageable

      before_action :set_organization, only: [:show, :edit, :update, :destroy, :follow, :unfollow]

      # GET /organizations
      def index
        if params[:include_deleted].present? and params[:include_deleted] == "true"
          @organizations = Organization.with_deleted
        else
          @organizations = Organization.all
        end
        @organizations = @organizations.where(:owner_id => params[:owner_id]) if params[:owner_id]
        @organizations = @organizations.where("lower(contacts.name) LIKE ?", "%#{params[:name].downcase}%") if params[:name].present?
        @organizations = @organizations.where("lower(contacts.abbreviation) LIKE ?", "%#{params[:abbreviation].downcase}%") if params[:abbreviation].present?
        @organizations = @organizations.joins(:owner).where("lower(users.name) LIKE ?", "%#{params[:owner_name].downcase}%") if params[:owner_name].present?
        render json: to_pageable(@organizations)
      end

      # GET /organizations/1
      def show
        render json: @organization
      end

      # GET /organizations/new
      def new
        @organization = Organization.new
      end

      # GET /organizations/1/edit
      def edit
      end

      # POST /organizations
      def create
        @organization = Organization.new(organization_update_params)
        if @organization.save
          render json: @organization
        else
          render json: @organization.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /organizations/1
      def update
        if params[:restore].present? and params[:restore] == "true"
          @organization.changed_by = current_user
          @organization.restore!
          render json: @organization
        else
          if @organization.update(organization_update_params)
            render json: @organization
          else
            render json: @organization.errors, status: :unprocessable_entity
          end
        end
      end

      # DELETE /organizations/1
      def destroy
        @organization.changed_by = current_user
        @organization.destroy
        render json: @organization
      end

      def follow
        @organization.follow_by(current_user)
        render json: @organization
      end

      def unfollow
        @organization.unfollow_by(current_user)
        render json: @organization
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_organization
          @organization = Organization.with_deleted.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def organization_update_params
          params.require(:organization).permit(:name, :abbreviation, :address, :remarks, :url, :owner_id).merge(:changed_by => current_user)
        end

    end
  end
end
