module Api
  module V1

    class PeopleController < ApplicationController

      include Pageable

      before_action :set_person, only: [:show, :edit, :update, :destroy]

      # GET /people
      def index
        @people = Person.all
        @people = @people.where("lower(name) LIKE ?", "%#{params[:name].downcase}%") if params[:name].present?
        @people = @people.where("lower(phone) LIKE ?", "%#{params[:phone].downcase}%") if params[:phone].present?
        @people = @people.where("lower(email) LIKE ?", "%#{params[:email].downcase}%") if params[:email].present?
        @people = @people.joins(:organization).where("lower(organizations_contacts.name) LIKE ?", "%#{params[:organization_name].downcase}%") if params[:organization_name].present?
        @people = @people.joins(:owner).where("lower(users.username) LIKE ?", "%#{params[:owner_name].downcase}%") if params[:owner_name].present?
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
          render json: @person, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /people/1
      def update
        if @person.update(person_params)
          render json: @person
        else
          render json: @person, status: :unprocessable_entity
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
          @person = Person.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def person_params
          params.require(:person).permit(:name, :organization_id, :phone, :email, :address, :remarks, :owner_id)
        end
    end

  end
end