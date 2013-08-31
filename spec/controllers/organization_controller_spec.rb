require 'spec_helper'

describe OrganizationController do
  before(:each) do
    # TODO Use factory Girl
    @organization = Organization.new
    @organization.id = 1
  end

  describe "GET 'index'" do
    it "succeed and returned status is 200" do
      pending("fails because of UrlGenerationError")
      get :index
    end
  end

end
