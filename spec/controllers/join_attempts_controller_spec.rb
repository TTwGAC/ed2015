require 'spec_helper'

describe JoinAttemptsController do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:player]
    @current_player = FactoryGirl.build(:player)
    @current_player.confirm!
    sign_in @current_player
  end

  it %q{should process a join request} do
    ja = mock :join_attempt
    JoinAttempt.should_receive(:new).once.with("player" => @current_player, "token" => 'abcd').and_return ja
    ja.should_receive(:save!).once
    get :create, {join_attempt: {token: 'abcd'}}
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
