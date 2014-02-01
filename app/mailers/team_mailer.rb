class TeamMailer < ActionMailer::Base
  default from: "noreply@gac2014.com"

  def notify_team_created(player, team, recipient)
    @player, @team, @recipient = player, team, recipient
    mail to: recipient.email, from: player.email, subject: "[GAC2014] New team created: #{team.name}"
  end

  def invitation_to_join(player, team, recipient)
    @player, @team, @recipient = player, team, recipient
    mail to: recipient, from: player.email, subject: "[GAC2014] Invitation to join team #{team.name}"
  end

  def notify_member_joined(joining_player, notified_player, team)
    @joining_player, @team = joining_player, team
    mail to: notified_player.email, from: 'gchq@gac2014.com', subject: "[GAC2014] #{joining_player.nickname} has joined team #{team.name}"
  end

  def send_puzzle(player, puzzle)
    @player, @puzzle = player, puzzle
    mail to: player.email, subject: "[GAC2014] Your Next Puzzle: #{puzzle.name}"
  end
end
