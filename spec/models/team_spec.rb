require 'spec_helper'

describe Team do
  it "should disallow reserved team names" do
    expect { t = Team.create! name: 'Game Control' }.to raise_error
  end

  it "should have the default teams defined" do
    Team.where(name: "Game Control").should_not be_empty
    Team.where(name: "Observers").should_not be_empty
  end
end