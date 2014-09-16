require "spec_helper"

describe GameController do
  describe "routing" do

    it "routes to #index" do
      get("/game").should route_to("game#show")
    end

    it "routes to #edit" do
      get("/game/edit").should route_to("game#edit")
    end

    it "routes to #update" do
      put("/game").should route_to("game#update")
    end

  end
end
