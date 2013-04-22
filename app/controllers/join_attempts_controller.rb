class JoinAttemptsController < ApplicationController
  def index
    @join_attempt = JoinAttempt.new
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  def create
    @join_attempt = JoinAttempt.new params[:join_attempt]
    if @join_attempt.save!
      flash[:notice] = "You have successfully joined this team!"
      redirect_to teams_path
    else
      redirect_to join_attempts_path
    end
  end
end