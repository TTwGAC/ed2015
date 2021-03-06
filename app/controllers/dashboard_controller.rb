# encoding: utf-8
require 'faraday'

class DashboardController < ApplicationController
  before_filter :authenticate_player!

  # GET /puzzles
  # GET /puzzles.json
  def show
    if can? :manage, :all
      game_control_dashboard
    else
      player_dashboard
    end
  end

  def game_control_dashboard
    @locations = Location.all
    @radio_gac_stats = get_radio_gac_stats
    @puzzle_stats    = get_puzzle_stats
    @penalty_stats   = get_penalty_stats
    @checkin_stats   = get_checkin_stats

    respond_to do |format|
      format.html do
        # Render the UI
        render :game_control_dashboard, layout: false
      end
      format.json do
        # Return just the data to update the UI
      end
    end
  end

  def player_dashboard
    @puzzle = current_player.team_current_puzzle || Puzzle.new
    @penalties = current_player.team_penalties
    current_location = current_player.team_location
    next_location = @puzzle.destination
    if current_location && next_location
      @location_coordinates = [current_location.latitude, current_location.longitude]
      @next_location_coordinates = [next_location.latitude, next_location.longitude]
    end
    respond_to do |format|
      format.html do
        # Render the UI
        render :player_dashboard
      end
    end
  end

private

  def get_radio_gac_stats
    response = icecast_api('/admin/stats')
    logger.warn "Icecast response: #{response.inspect}"
    stats = {}
    if response.status == 200
      xml = Nokogiri::XML(response.body)
      if xml.xpath("/icestats/source[@mount='/radio_gac']").present?
        channel = 'radio_gac'
      else
        channel = 'auto-dj'
      end

      stats[:listeners] = xml.xpath("/icestats/source[@mount='/#{channel}']/listeners").text.to_i
      stats[:track]     = xml.xpath("/icestats/source[@mount='/#{channel}']/title").text
    else
      # The server returns 400 when no users are connected
      stats[:listeners] = 0
      stats[:track]     = "Unknown"
    end

    stats
  end

  def icecast_api(query, params = {})
    unless @icecast_api
      @icecast_api = Faraday.new(url: 'http://gchq.gac2014.com:8000') do |faraday|
        faraday.response :logger
        faraday.adapter Faraday.default_adapter
      end
      @icecast_api.basic_auth ENV['ICECAST_USERNAME'], ENV['ICECAST_PASSWORD']
    end

    @icecast_api.get query, params
  end

  def get_puzzle_stats
    stats = {}
    stats[:total] = Puzzle.active.count
    # This should a faster query then checking each puzzle for #open?
    stats[:open] = Checkin.select(:solved_puzzle_id).distinct.map(&:solved_puzzle_id).compact.count
    stats[:complete] = Puzzle.active.select { |p| p.completed? }.count
    stats[:unopened] = stats[:total] - stats[:open]
    stats
  end

  def get_penalty_stats
    stats = {}
    stats[:total] = Penalty.count
    stats[:average] = Penalty.average(:minutes).round(1)
    team_penalties = Penalty.group(:team_id).sum(:minutes)
    team_penalties = team_penalties.sort_by { |team_id, minutes| minutes }
    team_id, minutes = team_penalties.last
    stats[:worst_team] = "#{Team.find(team_id).name}: #{minutes.to_i}"
    team_id, minutes = team_penalties.first
    stats[:best_team] = "#{Team.find(team_id).name}: #{minutes.to_i}"
    stats
  end

  def get_checkin_stats
    stats = {}
    stats[:total] = Checkin.count
    total_checkin_time = Checkin.all.inject(0) { |i, c| i += c.time_to_complete.to_i }
    stats[:avg_ttc] = total_checkin_time / stats[:total]
    stats
  end

end
