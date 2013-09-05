require "spec_helper"

describe Api::V1::DealsController do
  describe "routing" do

    it "routes to #index" do
      get("/api/v1/deals").should route_to("api/v1/deals#index", format: 'json')
    end

    it "routes to #new" do
      get("/api/v1/deals/new").should route_to("api/v1/deals#new", format: 'json')
    end

    it "routes to #show" do
      get("/api/v1/deals/1").should route_to("api/v1/deals#show", :id => "1", format: 'json')
    end

    it "routes to #edit" do
      get("/api/v1/deals/1/edit").should route_to("api/v1/deals#edit", :id => "1", format: 'json')
    end

    it "routes to #create" do
      post("/api/v1/deals").should route_to("api/v1/deals#create", format: 'json')
    end

    it "routes to #update" do
      put("/api/v1/deals/1").should route_to("api/v1/deals#update", :id => "1", format: 'json')
    end

    it "routes to #destroy" do
      delete("/api/v1/deals/1").should route_to("api/v1/deals#destroy", :id => "1", format: 'json')
    end

  end
end
