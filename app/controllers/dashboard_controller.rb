# encoding: utf-8

class DashboardController < ApplicationController
  before_filter :authenticate_player!

  # GET /puzzles
  # GET /puzzles.json
  def show
    if can? :manage, :all
      game_control_dashboard
    else
      player_dashboard
    end
  end

  def game_control_dashboard
    respond_to do |format|
      format.html do
        # Render the UI
        render :game_control_dashboard
      end
      format.json do
        # Return just the data to update the UI
      end
    end
  end

  def player_dashboard
    @puzzle = current_player.team_current_puzzle
    @penalties = current_player.team_penalties
    respond_to do |format|
      format.html do
        # Render the UI
        render :player_dashboard
      end
    end
  end

end
