require 'spec_helper'

describe JoinAttempt do
  let(:team) { FactoryGirl.create :team }
  let(:player) { FactoryGirl.create :player, team: team }
  let(:invitation) { FactoryGirl.create :team_invitation, team: team }

  it %q{should look up a team by the team's token} do
    Team.should_receive(:where).once.with(token: team.token).and_return [team]
    attempt = JoinAttempt.new player: player, token: team.token
    attempt.should_receive(:persist!).once
    attempt.should_receive(:notify_team).once
    attempt.save
  end

  it %q{should look up a team by an invitation's token} do
    attempt = JoinAttempt.new player: player, token: invitation.token
    attempt.valid?.should be true
    attempt.team.should == team
  end

  it %q{should not process a team invitation with an invalid token} do
    attempt = JoinAttempt.new player: player, token: 'ABCD'
    attempt.should_receive(:persist!).never
    attempt.should_receive(:notify_team).never
    attempt.save.should be nil
  end

  it %q{should delete a TeamInvitation once processed}
end
