require 'spec_helper'

describe JoinAttemptsController do
  let(:current_player) { FactoryGirl.build(:player) }
  let(:team) { FactoryGirl.build(:team) }
  before :each do
    controller.stub(:current_player) do
      current_player
    end
  end

  it %q{should process a join request} do
    ja = mock :join_attempt
    JoinAttempt.should_receive(:new).once.with("player" => current_player, "token" => 'abcd').and_return ja
    ja.should_receive(:save!).once
    get :create, join_attempt: {token: 'abcd'}
  end


  it %q{should process a join request given a valid token in the request} do
    controller.should_receive(:create).once
    get :new, token: 'abcd'
  end

  it %q{should reset the current player's team to Observers when leaving a team} do
    get :destroy, id: team.id
    observers = Team.where(name: 'Observers').first
    current_player.team.should == observers
  end

end
