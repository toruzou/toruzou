class OrganizationController < ApplicationController
  before_action :set_organization, only: [:show, :destroy]
  def index
    @organizations = Organization.all
    render json: @organizations
  end

  def show
    # TODO serialize
  end

  def create
    # TODO implement
  end

  def update
    # TODO implement
  end

  def destroy

  end

  private 
  def set_organization
    begin
      @organization = Organization.find(params[:id])
    rescue
      # TODO send HTTP 400 
    end
  end

end
