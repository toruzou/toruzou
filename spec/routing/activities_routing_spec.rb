require "spec_helper"

describe Api::V1::ActivitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/api/v1/activities").should route_to("api/v1/activities#index", format: 'json')
    end

    it "routes to #new" do
      get("/api/v1/activities/new").should route_to("api/v1/activities#new", format: 'json')
    end

    it "routes to #show" do
      get("/api/v1/activities/1").should route_to("api/v1/activities#show", :id => "1", format: 'json')
    end

    it "routes to #edit" do
      get("/api/v1/activities/1/edit").should route_to("api/v1/activities#edit", :id => "1", format: 'json')
    end

    it "routes to #create" do
      post("/api/v1/activities").should route_to("api/v1/activities#create", format: 'json')
    end

    it "routes to #update" do
      put("/api/v1/activities/1").should route_to("api/v1/activities#update", :id => "1", format: 'json')
    end

    it "routes to #destroy" do
      delete("/api/v1/activities/1").should route_to("api/v1/activities#destroy", :id => "1", format: 'json')
    end

  end
end
