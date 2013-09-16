require "spec_helper"

describe Api::V1::OrganizationsController do
  describe "routing" do

    it "routes to #index" do
      get("/api/v1/organizations").should 
        route_to("api/v1/organizations#index", format: 'json')
    end

    it "routes to #new" do
      get("/api/v1/organizations/new").should 
        route_to("api/v1/organizations#new", format: 'json')
    end

    it "routes to #show" do
      get("/api/v1/organizations/1").should 
        route_to("api/v1/organizations#show", :id => "1", format: 'json')
    end

    it "routes to #edit" do
      get("/api/v1/organizations/1/edit").should 
        route_to("api/v1/organizations#edit", :id => "1", format: 'json')
    end

    it "routes to #create" do
      post("/api/v1/organizations").should 
        route_to("api/v1/organizations#create", format: 'json')
    end

    it "routes to #update" do
      put("/api/v1/organizations/1").should 
        route_to("api/v1/organizations#update", :id => "1", format: 'json')
    end

    it "routes to #destroy" do
      delete("/api/v1/organizations/1").should 
        route_to("api/v1/organizations#destroy", :id => "1", format: 'json')
    end

  end

  describe "routing organization/:id/people" do
    it "routes to people#index" do
      get("/api/v1/organizations/1/people").should 
        route_to("api/v1/people#index", format: 'json', organization_id: "1")
    end
    
    it "routes to people#show" do
      get("/api/v1/organizations/1/people/1").should 
        route_to("api/v1/people#index", format: 'json', 
                 organization_id: "1", id: "1")
    end

    it "routes to people#create" do
      post("/api/v1/organizations/1/people").should 
        route_to("api/v1/people#create", format: 'json', organization_id: "1")
    end

    it "routes to people#update" do
      put("/api/v1/organizations/1/people/1").should 
        route_to("api/v1/people#update", format: 'json', 
                 organization_id: "1", id: "1")
    end

    it "routes to people#delete" do
      delete("/api/v1/organizations/1/people/1").should 
        route_to("api/v1/people#destroy", format: 'json', 
                 organization_id: "1", id: "1")
    end

  end
end
