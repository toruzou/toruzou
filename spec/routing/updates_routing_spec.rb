require "spec_helper"

describe Api::V1::UpdatesController do
  describe "routing" do

    it "routes to #index" do
      get("/api/v1/updates").should route_to("api/v1/updates#index", format: 'json')
    end

    it "routes to #new" do
      get("/api/v1/updates/new").should route_to("api/v1/updates#new", format: 'json')
    end

    it "routes to #show" do
      get("/api/v1/updates/1").should route_to("api/v1/updates#show", :id => "1", format: 'json')
    end

    it "routes to #edit" do
      get("/api/v1/updates/1/edit").should route_to("api/v1/updates#edit", :id => "1", format: 'json')
    end

    it "routes to #create" do
      post("/api/v1/updates").should route_to("api/v1/updates#create", format: 'json')
    end

    it "routes to #update" do
      put("/api/v1/updates/1").should route_to("api/v1/updates#update", :id => "1", format: 'json')
    end

    it "routes to #destroy" do
      delete("/api/v1/updates/1").should route_to("api/v1/updates#destroy", :id => "1", format: 'json')
    end

  end
end
