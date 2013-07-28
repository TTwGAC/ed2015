require 'spec_helper'

describe CheckinsController do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:player]
    @current_player = FactoryGirl.build(:player)
    @current_player.confirm!
    sign_in @current_player
  end

  it %q{should look up a location by ID} do
    loc = FactoryGirl.build(:location)
    Location.should_receive(:where).once.and_return [loc]
    get :new, l: loc.token
    Checkin.last.location.should == loc
  end

  it %q{should return a 404 when given an invalid ID} do
    expect { get :new, l: 'asdf'  }.to raise_error ActionController::RoutingError 
  end
end
