class JoinAttemptsController < ApplicationController
  def new
    @join_attempt = JoinAttempt.new
    respond_to do |format|
      format.html
    end
  end

  def create
    params[:join_attempt][:player] = current_player
    @join_attempt = JoinAttempt.new params[:join_attempt]
    if @join_attempt.save!
      redirect_to team_path(@join_attempt.team_id)
    else
      render 'new'
    end
  end

  def destroy
    observers = Team.where(name: 'Observers').first
    current_player.team = observers
    current_player.save!
    redirect_to team_path
  end
end
