class TeamInvitationsController < ApplicationController
  before_filter :authenticate_player!
  before_filter do
    params[:team_invitation] &&= team_invitation_params
  end

  authorize_resource

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
      event "create", :team_invitation, @ti.id, description: "#{current_player.name} invited #{invite_params[:email]} to join team #{invite_params[:team].name}"
      mailer = TeamMailer.invitation_to_join current_player, current_player.team, invite_params[:email]
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
    event "delete", :team_invitation, ti.id, description: "#{current_player.name} deleted the invitation for #{ti.email} to join team #{ti.team_name}"
    redirect_to team_path ti.team_id
  end

private

  def team_invitation_params
    params.require(:team_invitation).permit(:team, :player, :email)
  end
end
