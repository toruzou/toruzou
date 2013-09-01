module Api
  module V1

    class OrganizationsController < ApplicationController

      include Pageable

      before_action :set_organization, only: [:show, :edit, :update, :destroy]

      # GET /organizations
      def index
        @organizations = Organization.all
        @organizations = @organizations.where("lower(name) LIKE ?", "%#{params[:name].downcase}%") if params[:name].present?
        @organizations = @organizations.where("lower(abbreviation) LIKE ?", "%#{params[:abbreviation].downcase}%") if params[:abbreviation].present?
        @organizations = @organizations.joins(:owner).where("lower(users.username) LIKE ?", "%#{params[:owner_name].downcase}%") if params[:owner_name].present?
        render json: to_pageable(@organizations)
      end

      # GET /organizations/1
      def show
        @organization = Organization.find(params[:id])
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
        # TODO validation, etc ...
        @organization = Organization.new(organization_params)
        if @organization.save
          render json: @organization
        else
          render json: @organization, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /organizations/1
      def update
        if @organization.update(organization_params)
          render json: @organization
        else
          render json: @organization, status: :unprocessable_entity
        end
      end

      # DELETE /organizations/1
      def destroy
        @organization.destroy
        redirect_to organizations_url, notice: 'Organization was successfully destroyed.'
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_organization
          @organization = Organization.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def organization_params
          params.require(:organization).permit(:name, :abbreviation, :address, :remarks, :url, :owner_id)
        end
        
    end

  end
end