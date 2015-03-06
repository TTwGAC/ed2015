class LocationsController < ApplicationController
  before_filter :authenticate_player_unless_game_closed
  before_filter do
    params[:location] &&= location_params
    @game = Game.instance
  end

  load_and_authorize_resource

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.order :name

    map_points = {}

    respond_to do |format|
      format.html
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])
    @location.cluster ||= Cluster.new(name: 'Unclustered', color: 'red')

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        event "create", :location, @location.id, description: "#{current_player.name} created new location #{@location.name}"
        format.html { redirect_to @location, flash: { success: 'Location was successfully created.' } }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(location_params)
        event "update", :location, @location.id, description: "#{current_player.name} updated the details for #{@location.name}"
        format.html { redirect_to @location, flash: { success: 'Location was successfully updated.' } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    event "delete", :location, @location.id, description: "#{current_player.name} deleted location #{@location.name}"

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  def posters
    if params[:location_id] == 'all'
      @locations = Location.order :name
    elsif params[:location_id] == 'tarpit'
      # Special tarpit location
      @locations = [OpenStruct.new(name: '54 Columns', token: '77ab09c2f1928cd50b342958a1b2ba88')]
    else
      @locations = [Location.find(params[:location_id])]
    end
    render :poster, layout: false
  end

private
  def location_params
    #if params['location']['open_time(4i)'] == ''
    #  (1..5).each {|i| params['location']["open_time(#{i}i)"] = nil}
    #end
    #if params['location']['close_time(4i)'] == ''
    #  (1..5).each {|i| params['location']["close_time(#{i}i)"] = nil}
    #end
    params.require(:location).permit(:name, :address, :latitude, :longitude, :cluster_id, :permission_received, :next_puzzle_id, :open_time, :close_time)
  end
end
