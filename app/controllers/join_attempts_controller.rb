class JoinAttemptsController < ApplicationController
  before_filter :authenticate_player!
  authorize_resource

  def new
    if params[:token]
      params[:join_attempt] = {}
      params[:join_attempt][:token] = params.delete :token
      create
    else
      @join_attempt = JoinAttempt.new
      respond_to do |format|
        format.html
      end
    end
  end

  def create
    params[:join_attempt][:player] = current_player
    @join_attempt = JoinAttempt.new params[:join_attempt]
    if @join_attempt.save!
      redirect_to team_path(@join_attempt.team_id)
    else
      flash[:error] = "Unable to join team: Invalid token"
      render 'new'
    end
  end

  def destroy
    observers = Team.where(name: 'Observers').first
    current_player.team = observers
    current_player.save!
    redirect_to root_path
  end
end
