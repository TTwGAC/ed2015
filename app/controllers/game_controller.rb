# encoding: utf-8

class GameController < ApplicationController
  before_filter :authenticate_player!
  before_filter do
    params[:game] &&= game_params
  end

  load_and_authorize_resource

  # GET /game
  # GET /game.json
  def show
    @game = Game.instance

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.instance
  end

  # PATCH/PUT /game
  # PATCH/PUT /game.json
  def update
    @game = Game.instance

    respond_to do |format|
      if @game.update_attributes(game_params)
        format.html { redirect_to game_path, flash: { success: 'Game was successfully updated.' } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def game_params
      params.require(:game).permit(:name, :status, :hotline_open)
    end
end
