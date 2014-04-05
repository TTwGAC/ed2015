class TeamMailer < ActionMailer::Base
  default from: "noreply@gac2014.com"
  SUBJECT_TAG = '[GAC2014]'

  def notify_team_created(player, team, recipient)
    @player, @team, @recipient = player, team, recipient
    mail to: recipient.email, from: player.email, subject: "#{SUBJECT_TAG} New team created: #{team.name}"
  end

  def invitation_to_join(player, team, recipient)
    @player, @team, @recipient = player, team, recipient
    mail to: recipient, from: player.email, subject: "#{SUBJECT_TAG} Invitation to join team #{team.name}"
  end

  def notify_member_joined(joining_player, notified_player, team)
    @joining_player, @team = joining_player, team
    mail to: notified_player.email, subject: "#{SUBJECT_TAG} #{joining_player.nickname} has joined team #{team.name}"
  end

  def send_puzzle(player, checkin)
    @player, @checkin = player, checkin
    @puzzle = checkin.next_puzzle
    @location_coordinates = checkin.location_coordinates
    @next_location_coordinates = checkin.next_location_coordinates
    mail to: player.email, subject: "#{SUBJECT_TAG} Your Next Puzzle: #{@puzzle.name}"
  end
end
