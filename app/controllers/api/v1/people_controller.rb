module Api
  module V1

    class PeopleController < ApplicationController

      include Pageable

      before_action :set_person, only: [:show, :edit, :update, :destroy]

      # GET /people
      def index
        @people = Person.all
        @people = @people.in_organization(params[:organization_id]) if params[:organization_id].present?
        @people = @people.match_name(params[:name]) if params[:name].present?
        @people = @people.match_phone(params[:phone]) if params[:phone].present?
        @people = @people.match_email(params[:email]) if params[:email].present?
        @people = @people.match_organization(params[:organization_name]) if params[:organization_name].present?
        @people = @people.match_owner(params[:owner_name]) if params[:owner_name].present?
        render json: to_pageable(@people)
      end

      # GET /people/1
      def show
        render json: @person
      end

      # GET /people/new
      def new
        @person = Person.new
      end

      # GET /people/1/edit
      def edit
      end

      # POST /people
      def create
        @person = Person.new(person_params)
        if @person.save
          render json: @person
        else
          render json: remove_empty_value_from(@person.errors), status: :unprocessable_entity
        end
      end

      # PATCH/PUT /people/1
      def update
        if @person.update(person_params)
          render json: @person
        else
          render json: remove_empty_value_from(@person.errors), status: :unprocessable_entity
        end
      end

      # DELETE /people/1
      def destroy
        @person.destroy
        render json: @person
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_person
          if params[:organization_id].present? then
            @person = Person.has_organization_id(params[:organization_id]).find(params[:id])
          else
            @person = Person.find(params[:id])
          end
        end

        # Only allow a trusted parameter "white list" through.
        def person_params
          params.require(:person).permit(:name, :organization_id, :phone, :email, :address, :remarks, :owner_id)
        end

        # workaround for plugin "validates_email_format_of" returning empty array for 'email' key
        def remove_empty_value_from(hash)
          if hash[:email] == [] then
            hash.delete(:email)
          end
          hash
        end
    end

  end
end
