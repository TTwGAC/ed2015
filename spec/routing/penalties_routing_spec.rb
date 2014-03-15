require "spec_helper"

describe PenaltiesController do
  describe "routing" do

    it "routes to #index" do
      get("/penalties").should route_to("penalties#index")
    end

    it "routes to #new" do
      get("/penalties/new").should route_to("penalties#new")
    end

    it "routes to #show" do
      get("/penalties/1").should route_to("penalties#show", :id => "1")
    end

    it "routes to #edit" do
      get("/penalties/1/edit").should route_to("penalties#edit", :id => "1")
    end

    it "routes to #create" do
      post("/penalties").should route_to("penalties#create")
    end

    it "routes to #update" do
      put("/penalties/1").should route_to("penalties#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/penalties/1").should route_to("penalties#destroy", :id => "1")
    end

  end
end
