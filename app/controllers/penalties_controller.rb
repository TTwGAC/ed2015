# encoding: utf-8

class PenaltiesController < ApplicationController
  before_filter :authenticate_player!
  before_filter do
    params[:penalty] &&= penalty_params
  end

  load_and_authorize_resource

  # GET /penalties
  # GET /penalties.json
  def index
    @penalties = @penalties.order 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @penalties }
    end
  end

  # GET /penalties/1
  # GET /penalties/1.json
  def show
    @penalty = Penalty.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @penalty }
    end
  end

  # GET /penalties/new
  # GET /penalties/new.json
  def new
    @penalty = Penalty.new minutes: 0

    [:team_id, :puzzle_id, :minutes, :description].each do |param|
      @penalty.send "#{param}=", params[param] if params.has_key?(param)
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @penalty }
    end
  end

  # GET /penalties/1/edit
  def edit
    @penalty = Penalty.find(params[:id])
  end

  # POST /penalties
  # POST /penalties.json
  def create
    @penalty = Penalty.new(penalty_params)
    @penalty.assigner = current_player

    respond_to do |format|
      if @penalty.save
        format.html { redirect_to @penalty, notice: 'Penalty was successfully created.' }
        format.json { render json: @penalty, status: :created, location: @penalty }
      else
        format.html { render action: "new" }
        format.json { render json: @penalty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /penalties/1
  # PATCH/PUT /penalties/1.json
  def update
    @penalty = Penalty.find(params[:id])

    respond_to do |format|
      if @penalty.update_attributes(penalty_params)
        format.html { redirect_to @penalty, notice: 'Penalty was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @penalty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /penalties/1
  # DELETE /penalties/1.json
  def destroy
    @penalty = Penalty.find(params[:id])
    @penalty.destroy

    respond_to do |format|
      format.html { redirect_to penalties_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def penalty_params
      params.require(:penalty).permit(:description, :minutes, :puzzle_id, :team_id)
    end
end
