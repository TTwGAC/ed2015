class InvitationMailer < ActionMailer::Base
  default from: "from@example.com"

  def invitation_to_join(player, team, recipient)
    @player, @team, @recipient = player, team, recipient
    mail to: recipient, subject: "GAC2014: Invitation to join team #{team.name}"
  end

end
