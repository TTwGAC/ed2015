require 'spec_helper'

describe PlayersController do
  it "should find a player" do
    player = FactoryGirl.build(:player)
    player.role.should == 'player'
  end

  it "should filter out private player data"

end
