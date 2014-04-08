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
    @radio_gac = get_radio_gac_info
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
    respond_to do |format|
      format.html do
        # Render the UI
        render :player_dashboard
      end
    end
  end

private

  def get_radio_gac_info
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

end
