require 'spec_helper'

describe TeamInvitationsController do
  let(:current_player) { FactoryGirl.build(:player) }
  let(:team) { FactoryGirl.build(:team) }
  before :each do
    controller.stub(:current_player) do
      current_player.team = team
      current_player
    end
  end

  it %q{should assign the invitation to the current player and the current player's team} do
    params = {:email => 'foo@xyz.com', :player => current_player, :team => team}
    invite = mock :invitation
    TeamInvitation.should_receive(:new).once.with(params).and_return invite
    invite.should_receive(:save)
    post :create, team_invitation: {email: 'foo@xyz.com'}
  end

  it %q{should mail the invitation to the invitee} do
    invite = mock :invitation
    TeamInvitation.should_receive(:new).once.and_return invite
    invite.should_receive(:save).and_return true
    mailer = mock :mailer
    TeamMailer.should_receive(:invitation_to_join).once.with(current_player, team, 'foo@xyz.com').and_return mailer
    mailer.should_receive(:deliver).once
    post :create, team_invitation: {email: 'foo@xyz.com'}
  end

  it %q{should not allow duplicate invitations to be sent to the same email address}

  it %q{should allow resending an invitation to an existing invitee}

  it %q{should disallow sending invitations to the Observer team}

end

