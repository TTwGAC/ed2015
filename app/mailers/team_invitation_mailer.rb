class TeamInvitationMailer < ActionMailer::Base
  default from: "noreply@gac2014.com"

  def invitation_to_join(player, team, recipient)
    @player, @team, @recipient = player, team, recipient
    mail to: recipient, from: player.email, subject: "[GAC2014] Invitation to join team #{team.name}"
  end

end
