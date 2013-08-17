class LocationsController < ApplicationController
  before_filter :authenticate_player!
  before_filter do
    params[:location] &&= location_params
  end

  authorize_resource

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all

    respond_to do |format|
      format.html do
        @locations_map_data = @locations.to_gmaps4rails do |loc, marker|
          marker.infowindow render_to_string partial: '/locations/infowindow', locals: {loc: loc}
          marker.json name: loc.name, address: loc.address
        end
        render html: @locations
      end
      format.json { render json: @locations }
    end
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

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
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
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
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
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

private
  def location_params
    params.require(:location).permit(:name, :address, :latitude, :longitude)
  end
end
