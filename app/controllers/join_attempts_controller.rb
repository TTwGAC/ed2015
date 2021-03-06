class JoinAttemptsController < ApplicationController
  before_filter do
    session[:team_invitation_token] = params[:token] if params[:token]
  end

  before_filter :authenticate_player!
  load_and_authorize_resource

  def new
    token = params.delete(:token) || session[:team_invitation_token]
    if token
      # session #delete doesn't work: https://www.ruby-forum.com/topic/103267
      session[:team_invitation_token] = nil
      params[:join_attempt] = { token: token }
      create
    else
      @join_attempt = JoinAttempt.new
      @team = Team.new
      respond_to do |format|
        format.html
      end
    end
  end

  def create
    params[:join_attempt][:player] = current_player
    @join_attempt = JoinAttempt.new params[:join_attempt]
    if @join_attempt.save!
      event "create", :join_attempt, nil, description: "#{current_player.name} has joined team #{current_player.team_name}"
      flash[:success] = "You have successfully joined this team!"
      redirect_to team_path(@join_attempt.team_id)
    else
      flash[:error] = "Unable to join team: Invalid token"
      @join_attempt ||= JoinAttempt.new
      @team ||= Team.new
      render 'new'
    end
  end

  def destroy
    old_team = current_player.team
    observers = Team.where(name: 'Observers').first
    current_player.team = observers
    current_player.save!
    event "create", :join_attempt, nil, description: "#{current_player.name} has left team #{old_team.name} for #{current_player.team_name}"
    redirect_to root_path
  end
end
