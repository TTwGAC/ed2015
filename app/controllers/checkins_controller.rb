class CheckinsController < ApplicationController
  before_filter :authenticate_player_unless_game_closed
  before_filter do
    params[:checkin] &&= checkin_params
  end

  load_and_authorize_resource

  # GET /checkins
  # GET /checkins.json
  def index
    @checkins = @checkins.order 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkins }
    end
  end

  # GET /checkins/1
  # GET /checkins/1.json
  def show
    @checkin = Checkin.find(params[:id])
    @puzzle = @checkin.next_puzzle
    @location_coordinates = @checkin.location_coordinates
    @next_location_coordinates = @checkin.next_location_coordinates

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @checkin }
    end
  end

  # GET /checkins/new
  # GET /checkins/new.json
  def new
    if params[:t]
      # Check for the special tarpit token
      if params[:t] == '77ab09c2f1928cd50b342958a1b2ba88'
        sleep 10
        raise ActionController::RoutingError.new('Not Found')
      end

      location = Location.where(token: params.delete(:t)).first
      raise CanCan::AccessDenied.new('No such location!') unless location

      @new_params = {location: location, team: current_player.team}

      create
      return
    end

    # Only admins should ever see the "New Checkin" form.
    # We should never get here, but just in case...
    raise CanCan::AccessDenied.new('Where is your token!?') unless can? :manage, Checkin

    @checkin = Checkin.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @checkin }
    end
  end

  # GET /checkins/1/edit
  def edit
    @checkin = Checkin.find(params[:id])
  end

  # POST /checkins
  # POST /checkins.json
  def create
    params = @new_params || checkin_params

    params[:player] = current_player

    begin
      @checkin = Checkin.find_or_create params
      @location = @checkin.location
    rescue Checkin::Error => e
      @checkin = nil
      flash[:error] = e.message
    end

    respond_to do |format|
      if @checkin
        event "create", :checkin, @checkin.id, description: "#{current_player.name} checked in for team #{@checkin.team_name} to #{@checkin.location_name}"
        format.html { redirect_to '/dashboard', flash: { success: 'Checkin was successfully created.' } }
        format.json { render json: @checkin, status: :created, location: @checkin }
      else
        format.html { redirect_to checkins_url }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /checkins/1
  # PUT /checkins/1.json
  def update
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      if @checkin.update_attributes(checkin_params)
        event "update", :checkin, @checkin.id, description: "#{current_player.name} updated the checkin details for #{@checkin.team_name}'s checkin to #{@checkin.location_name}"
        format.html { redirect_to @checkin, flash: { success: 'Checkin was successfully updated.' } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkins/1
  # DELETE /checkins/1.json
  def destroy
    @checkin = Checkin.find(params[:id])
    @checkin.destroy
    event "delete", :checkin, @checkin.id, description: "#{current_player.name} deleted #{@checkin.player_name}'s checkin for team #{@checkin.team_name} to #{@checkin.location_name}"

    respond_to do |format|
      format.html { redirect_to checkins_url }
      format.json { head :no_content }
    end
  end

private

  def checkin_params
    params.require(:checkin).permit(:location_id, :team_id)
    #params.require(:checkin).permit(:location_id, :team_id, :timestamp) # for when timestamp updating works
  end
end
