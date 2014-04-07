class PlayersController < ApplicationController
  before_filter do
    params[:player] &&= player_params
  end

  load_and_authorize_resource

  # GET /players
  # GET /players.json
  def index
    collection = if request.query_parameters.present?
      Player.where request.query_parameters
    else
      Player.all
    end

    @players = collection.order 'first_name'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @players.to_json(only: public_attrs)  }
    end
  end

  # GET /players/1
  # GET /players/1.json
  def show
    @player = Player.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @player.to_json(only: public_attrs)  }
    end
  end

  # GET /players/new
  # GET /players/new.json
  def new
    @player = Player.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @player.to_json(only: public_attrs)  }
    end
  end

  # GET /players/1/edit
  def edit
    @player = Player.find(params[:id])
  end

  # POST /players
  # POST /players.json
  def create
    @player = Player.new(player_params)

    respond_to do |format|
      if @player.save
        event "create", :player, @player.id, description: "#{current_player.name} created player #{@player.name}"
        format.html { redirect_to @player, notice: 'Player was successfully created.' }
        format.json { render json: @player.to_json(only: public_attrs), status: :created, location: @player }
      else
        format.html { render action: "new" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /players/1
  # PUT /players/1.json
  def update
    @player = Player.find(params[:id])

    respond_to do |format|
      if @player.update_attributes(player_params)
        event "update", :player, @player.id, description: "#{current_player.name} updated the information for #{@player.name}"
        format.html { redirect_to @player, notice: 'Player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /players/1
  # DELETE /players/1.json
  def destroy
    @player = Player.find(params[:id])
    @player.destroy
    event "delete", :player, @player.id, description: "#{current_player.name} deleted player #{@player.name}"

    respond_to do |format|
      format.html { redirect_to players_url }
      format.json { head :no_content }
    end
  end
private

  def public_attrs
    [:id, :first_name, :last_name, :nickname, :team_id, :avatar, :created, :modified]
  end

  def player_params
    params.require(:player).permit(:email, :first_name, :last_name, :nickname, :phone, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache)
  end
end
