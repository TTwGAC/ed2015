require 'spec_helper'

describe CheckinsController do
  include ControllerSpecMixin

  before :each do
    sign_in_as :player
  end

  let(:loc) { FactoryGirl.build(:location_A) }

  it %q{should return a 404 when given an invalid ID} do
    expect { get :new, l: 'asdf'  }.to raise_error ActionController::RoutingError 
  end

  it %q{should return a 404 when given an ID instead of a token}

  it %q{should look up a location by ID} do
    Location.should_receive(:where).once.and_return [loc]
    get :new, l: loc.token
    Checkin.last.location.should == loc
  end

  it %q{should set the current team's location to the found location} do
    subject.current_player.team_location.should be nil
    Location.should_receive(:where).once.and_return [loc]
    get :new, l: loc.token
    subject.current_player.team_location.should == loc
  end

  it %q{should permit multiple checkins by the same team from a specific location}
end
