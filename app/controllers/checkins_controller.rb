class CheckinsController < ApplicationController
  before_filter :authenticate_player!
  before_filter do
    params[:checkin] &&= checkin_params
  end

  authorize_resource

  # GET /checkins
  # GET /checkins.json
  def index
    @checkins = Checkin.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @checkins }
    end
  end

  # GET /checkins/1
  # GET /checkins/1.json
  def show
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @checkin }
    end
  end

  # GET /checkins/new
  # GET /checkins/new.json
  def new
    @location = Location.where(token: params[:l]).first
    raise ActionController::RoutingError.new('No such location!') unless @location

    @checkin = Checkin.new player: current_player, team: current_player.team, location: @location
    if @checkin.save!
      event action, :checkin, @checkin.id, description: "#{current_player.name} on #{current_player.team_name} checked in at #{@location.name}"
      current_player.team_location = @location
      current_player.save!

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @checkin }
      end
    end
  end

  # GET /checkins/1/edit
  def edit
    @checkin = Checkin.find(params[:id])
  end

  # POST /checkins
  # POST /checkins.json
  def create
    @checkin = Checkin.new(checkin_params)

    respond_to do |format|
      if @checkin.save
        current_player.checkin = @checkin
        current_player.save!

        admins = Checkin.where(name: 'Game Control').first.players
        admins.each do |admin|
          mailer = CheckinMailer.notify_checkin_created current_player, @checkin, admin
          mailer.deliver!
        end

        event "create", :checkin, @checkin.id, params: checkin_params
        format.html { redirect_to @checkin, notice: 'Checkin was successfully created.' }
        format.json { render json: @checkin, status: :created, location: @checkin }
      else
        format.html { render action: "new" }
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
        event "update", :checkin, @checkin.id, params: checkin_params
        format.html { redirect_to @checkin, notice: 'Checkin was successfully updated.' }
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

  def public_attrs
    [:id, :name, :slogan, :description, :created_at, :updated_at]
  end

  def checkin_params
    allowed = [:name, :slogan, :description, :logo, :logo_cache, :phone]
    allowed << :paid if can? :manage, Checkin
    params.require(:checkin).permit(*allowed)
  end
end
