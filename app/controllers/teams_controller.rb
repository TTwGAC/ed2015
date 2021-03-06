class TeamsController < ApplicationController
  before_filter do
    params[:team] &&= team_params
  end

  load_and_authorize_resource

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.player.order('name')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams.to_json(only: public_attrs) }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      if can? :manage, @team
        format.json { render json: @team }
      else
        format.json { render json: @team.to_json(only: public_attrs) }
      end
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @team = Team.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        event "create", :team, @team.id, description: "#{current_player.name} created team #{@team.name}"
        current_player.team = @team
        current_player.save!

        admins = Team.where(name: 'Game Control').first.players
        admins.each do |admin|
          mailer = TeamMailer.notify_team_created current_player, @team, admin
          mailer.deliver!
        end

        format.html { redirect_to @team, flash: { success: 'Team was successfully created.' } }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @team = Team.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(team_params)
        event "update", :team, @team.id, description: "#{current_player.name} updated the information for team #{@team.name}"
        format.html { redirect_to @team, flash: { success: 'Team was successfully updated.' } }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team = Team.find(params[:id])
    @team.destroy
    event "delete", :team, @team.id, description: "#{current_player.name} deleted team #{@team.name}"

    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

private

  def public_attrs
    [:id, :name, :slogan, :description, :created_at, :updated_at] 
  end

  def team_params
    allowed = [:name, :slogan, :description, :logo, :logo_cache, :phone]
    allowed += [:paid, :active] if can? :manage, Team
    params.require(:team).permit(*allowed)
  end
end
