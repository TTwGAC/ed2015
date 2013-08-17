class EventsController < ApplicationController
  before_filter :authenticate_player!
  before_filter do
    params[:event] &&= event_params
  end
  load_and_authorize_resource

  # GET /teams
  # GET /teams.json
  def index
    params[:start] ||= 0
    params[:limit] ||= 10
    @events = Event.order("created_at DESC").limit(params[:limit]).offset(params[:start])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events.to_json }
    end
  end

private 

  def event_params
    params.require(:event).permit(:start, :limit)
  end
end

