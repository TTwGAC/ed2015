require 'spec_helper'

describe TeamsController do

  it "should list teams" do
    pending
    team = FactoryGirl.build :team
    Team.should_receive(:where).and_return [team]
    get :index
    assigns(:teams).should include Team.first conditions: {name: "Swinging Vines"}
  end

  it "should hide the Observers team" do
    get :index
    assigns(:teams).should_not include Team.first conditions: {name: "Observers"}
  end

  it "should filter out team tokens"
end
