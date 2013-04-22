require 'spec_helper'

describe TeamsController do

  it "should list teams" do
    get :index
    assigns(:teams).should include Team.first conditions: {name: "Game Control"}
  end

  it "should hide the Observers team" do
    get :index
    assigns(:teams).should_not include Team.first conditions: {name: "Observers"}
  end
end