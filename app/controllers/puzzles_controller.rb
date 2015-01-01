class PuzzlesController < ApplicationController
  before_filter :authenticate_player_unless_game_closed
  before_filter do
    params[:puzzle] &&= puzzle_params
  end

  load_and_authorize_resource

  # GET /puzzles
  # GET /puzzles.json
  def index
    @puzzles = Puzzle.order :name

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @puzzles }
    end
  end

  # GET /puzzles/1
  # GET /puzzles/1.json
  def show
    @puzzle = Puzzle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @puzzle }
    end
  end

  # GET /puzzles/new
  # GET /puzzles/new.json
  def new
    @puzzle = Puzzle.new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @puzzle }
    end
  end

  # GET /puzzles/1/edit
  def edit
    @puzzle = Puzzle.find(params[:id])
    @location = Location.new
  end

  # POST /puzzles
  # POST /puzzles.json
  def create
    @puzzle = Puzzle.new(puzzle_params)

    respond_to do |format|
      if @puzzle.save
        event "create", :puzzle, @puzzle.id, description: "#{current_player.name} created new puzzle #{@puzzle.name}"
        format.html { redirect_to @puzzle, notice: 'Puzzle was successfully created.' }
        format.json { render json: @puzzle, status: :created, location: @puzzle }
      else
        format.html { render action: "new" }
        format.json { render json: @puzzle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /puzzles/1
  # PATCH/PUT /puzzles/1.json
  def update
    @puzzle = Puzzle.find(params[:id])
    @location = Location.new

    respond_to do |format|
      if @puzzle.update_attributes(puzzle_params)
        event "update", :puzzle, @puzzle.id, description: "#{current_player.name} updated the details for puzzle #{@puzzle.name}"
        format.html { redirect_to @puzzle, notice: 'Puzzle was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @puzzle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /puzzles/1
  # DELETE /puzzles/1.json
  def destroy
    @puzzle = Puzzle.find(params[:id])
    @puzzle.destroy
    event "delete", :puzzle, @puzzle.id, description: "#{current_player.name} deleted puzzle #{@puzzle.name}"

    respond_to do |format|
      format.html { redirect_to puzzles_url }
      format.json { head :no_content }
    end
  end

private

  # Use this method to whitelist the permissible parameters. Example:
  # params.require(:person).permit(:name, :age)
  # Also, you can specialize this method with per-user checking of permissible attributes.
  def puzzle_params
    params.require(:puzzle).permit(:name, :status, :description, :flavortext, :expected_ttc, :destination_id, :owner_id, :include_bearing)
  end
end
