require 'spec_helper'

describe JoinAttempt do
  let(:player) { FactoryGirl.build(:player) }

  it %q{should look up a team by the team's token} do
    team = FactoryGirl.build(:team)
    Team.should_receive(:where).once.with(token: team.token).and_return [team]
    attempt = JoinAttempt.new player: player, token: team.token
    attempt.should_receive(:persist!).once
    attempt.save
  end

  it %q{should look up a team by an invitation's token} do
    ti = FactoryGirl.build(:team_invitation)
    Team.should_receive(:where).once.with(token: ti.token).and_return []
    TeamInvitation.should_receive(:where).once.with(token: ti.token).and_return [ti]
    ti.should_receive(:delete!).once

    attempt = JoinAttempt.new player: player, token: ti.token
    attempt.should_receive(:persist!).once
    attempt.save
  end

  it %q{should not process a team invitation with an invalid token} do
    Team.should_receive(:where).once.with(token: 'ABCD').and_return []
    TeamInvitation.should_receive(:where).once.with(token: 'ABCD').and_return []

    attempt = JoinAttempt.new player: player, token: 'ABCD'
    attempt.should_receive(:persist!).never
    attempt.save
  end

  it %q{should delete a TeamInvitation once processed}
end
