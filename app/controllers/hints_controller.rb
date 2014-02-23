# encoding: utf-8

class HintsController < ApplicationController
  before_filter :authenticate_player!
  before_filter do
    params[:hint] &&= hint_params
  end

  load_and_authorize_resource

  # GET /hints
  # GET /hints.json
  def index
    @puzzle = Puzzle.find(params['puzzle_id'])
    @hints = @puzzle.hints

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hints }
    end
  end

  # GET /hints/1
  # GET /hints/1.json
  def show
    @hint = Hint.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hint }
    end
  end

  # GET /hints/new
  # GET /hints/new.json
  def new
    @puzzle = Puzzle.find(params['puzzle_id'])
    @hint = Hint.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hint }
    end
  end

  # GET /hints/1/edit
  def edit
    @hint = Hint.find(params[:id])
    @puzzle = @hint.puzzle
  end

  # POST /hints
  # POST /hints.json
  def create
    @hint = Hint.new(hint_params)
    @hint.puzzle = Puzzle.find params['puzzle_id']

    respond_to do |format|
      if @hint.save
        format.html { redirect_to @hint.puzzle, notice: 'Hint was successfully created.' }
        format.json { render json: @hint, status: :created, location: @hint }
      else
        format.html { render action: "new" }
        format.json { render json: @hint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hints/1
  # PATCH/PUT /hints/1.json
  def update
    @hint = Hint.find(params[:id])

    respond_to do |format|
      if @hint.update_attributes(hint_params)
        format.html { redirect_to @hint.puzzle, notice: 'Hint was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hints/1
  # DELETE /hints/1.json
  def destroy
    @hint = Hint.find(params[:id])
    puzzle = @hint.puzzle
    @hint.destroy

    respond_to do |format|
      format.html { redirect_to puzzle }
      format.json { head :no_content }
    end
  end

private

  # Use this method to whitelist the permissible parameters. Example:
  # params.require(:person).permit(:name, :age)
  # Also, you can specialize this method with per-user checking of permissible attributes.
  def hint_params
    params.require(:hint).permit(:hint, :puzzle_id, :suggested_penalty)
  end
end
