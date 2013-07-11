require 'spec_helper'

describe JoinAttempt do
  let(:player) { FactoryGirl.build(:player) }

  it %q{should look up a team by the team's token} do
    team = FactoryGirl.build(:team)
    Team.should_receive(:first).once.with(conditions: {token: team.token}).and_return team
    attempt = JoinAttempt.new player: player, token: team.token
    attempt.should_receive(:persist!).once
    attempt.save
  end

  it %q{should look up a team by an invitation's token} do
    ti = FactoryGirl.build(:team_invitation)
    Team.should_receive(:first).once.with(conditions: {token: ti.token}).and_return nil
    TeamInvitation.should_receive(:first).once.with(conditions: {token: ti.token}).and_return ti

    attempt = JoinAttempt.new player: player, team: team
    attempt.should_receive(:persist!).once
    attempt.save
  end

end
