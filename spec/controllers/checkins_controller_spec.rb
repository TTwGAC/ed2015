require 'spec_helper'

describe CheckinsController do
  include ControllerSpecMixin

  before :each do
    sign_in_as :player
  end

  let(:loc) { FactoryGirl.build(:location_A) }

  it %q{should return a 403 and not create a checkin when given an invalid ID} do
    subject.should_not_receive :create
    response = get :new, t: 'asdf'
    response.response_code.should be 403
  end

  it %q{should return a 404 when given an ID instead of a token}

  it %q{should look up a location by ID} do
    Location.should_receive(:where).once.and_return [loc]
    get :new, t: loc.token
    Checkin.last.location.should == loc
  end

  it %q{should set the current team's location to the found location} do
    subject.current_player.team_location.should be nil
    Location.should_receive(:where).once.and_return [loc]
    get :new, t: loc.token
    subject.current_player.team_location.should == loc
  end

  it %q{should permit multiple checkins by the same team from a specific location}
end
