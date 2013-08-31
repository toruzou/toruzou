module Api
  module V1

    class OrganizationsController < ApplicationController

      include Pageable

      before_action :set_organization, only: [:show, :edit, :update, :destroy]

      # GET /organizations
      def index
        # TODO filtering
        @organizations = Organization.all
        render json: to_pageable(@organizations)
      end

      # GET /organizations/1
      def show
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
          redirect_to @organization, notice: 'Organization was successfully updated.'
        else
          render action: 'edit'
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