class JoinAttemptsController < ApplicationController
  def new
    @join_attempt = JoinAttempt.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  def create
    params[:join_attempt][:user] = current_user
    @join_attempt = JoinAttempt.new params[:join_attempt]
    if @join_attempt.save!
      redirect_to team_path(@join_attempt.team_id)
    else
      render 'new'
    end
  end
end