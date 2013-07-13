class TeamInvitationsController < ApplicationController
  def new
    @team_invitation = TeamInvitation.new
    respond_to do |format|
      format.html
    end
  end

  def create
    invite_params = {email: params[:team_invitation][:email], player: current_player, team: current_player.team}
    @ti = TeamInvitation.new invite_params
    if @ti.save
      mailer = TeamMailer.invitation_to_join current_player, current_player.team, params[:team_invitation][:email]
      mailer.deliver
      redirect_to team_path(current_player.team)
    else
      flash[:error] = "Unable to create invitation"
      render 'new'
    end
  end

  def destroy
    ti = TeamInvitation.find params[:id]
    ti.delete
    redirect_to team_path ti.team_id
  end

private

  def team_invitation_params
    params.require(:team_invitation).permit(:team, :player, :email)
  end
end
