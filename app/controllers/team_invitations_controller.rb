class TeamInvitationsController < ApplicationController
  def new
    @team_invitation = TeamInvitation.new
    respond_to do |format|
      format.html
    end
  end

  def create
    params[:team_invitation][:player] = current_player
    params[:team_invitation][:team] = current_player.team
    @ti = TeamInvitation.new params[:team_invitation]
    if @ti.save!
      mailer = TeamInvitationMailer.invitation_to_join current_player, current_player.team, params[:team_invitation][:email]
      puts mailer.inspect
      mailer.deliver
      redirect_to team_path(@ti.team_id)
    else
      render 'new'
    end
  end

  def destroy
    ti = TeamInvitation.find params[:id]
    ti.delete
    redirect_to team_path ti.team_id
  end
end