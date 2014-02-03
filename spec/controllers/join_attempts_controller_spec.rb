require 'spec_helper'

describe JoinAttemptsController, focus: true do
  include ControllerSpecMixin
  before :each do
    sign_in_as :player
  end

  it %q{should process a join request} do
    otherteam = FactoryGirl.create :otherteam, token: 'abcd'
    subject.current_player.team.should_not == otherteam
    get :create, {join_attempt: {token: 'abcd'}}
    subject.current_player.team.should == otherteam
  end


  it %q{should process a join request given a valid token in the request} do
    controller.should_receive(:create).once
    get :new, {token: 'abcd'}
    controller.params[:join_attempt][:token].should == 'abcd'
  end

  it %q{should reset the current player's team to Observers when leaving a team} do
    get :destroy
    observers = Team.where(name: 'Observers').first
    controller.current_player.team.should == observers
  end

end
