class TeamMailer < ActionMailer::Base
  default from: "noreply@gac2014.com"

  def invitation_to_join(player, team, recipient)
    @player, @team, @recipient = player, team, recipient
    mail to: recipient, from: player.email, subject: "[GAC2014] Invitation to join team #{team.name}"
  end

  def notify_member_joined(joining_player, notified_player, team)
    @joining_player, @team = joining_player, team
    mail to: notified_player.email, from: 'gchq@gac2014.com', subject: "[GAC2014] #{joining_player.nickname} has joined team #{team.name}"
  end
end
