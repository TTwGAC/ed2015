# encoding: utf-8

require 'uri'
require 'cgi'

module ApplicationHelper

  def display_base_errors resource
    return '' if (resource.errors.empty?) or (resource.errors[:base].empty?)
    messages = resource.errors[:base].map { |msg| content_tag(:p, msg) }.join
    html = <<-HTML
    <div class="alert alert-error alert-block">
      <button type="button" class="close" data-dismiss="alert">&#215;</button>
      #{messages}
    </div>
    HTML
    html.html_safe
  end

  def javascript(*files)
    content_for(:head) { javascript_include_tag(*files) }
  end

  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :warning then "alert"
      when :error then "alert alert-error"
      when :alert then "alert alert-error"
    end
  end

  def youtube_embed(ids, options = {})
    ids = Array(ids)
    src =  URI.parse "http://www.youtube.com/embed"
    params = {
      'autoplay' => 0,
      'origin' => 'http://gac2014.com'
    }
    case options[:type]
    when :videolist
      params['playlist'] = ids.join ","
    when :playlist
      params['list'] = ids.first
      params['listType'] = 'playlist'
    else
      src.path << "/#{id.first}"
    end

    query = []
    params.each_pair { |k,v| query << "#{CGI.escape k.to_s}=#{CGI.escape v.to_s}" }
    src.query = query.join "&"

    haml_tag :iframe, id: "ytplayer", type: "text/html", width: "640", height: "390", src: src.to_s, frameborder: "0"
  end

  def next_letter(letter)
    case letter
    when /[A-Y]/
      letter.next
    when nil, ''
      'A'
    else
      ''
    end
  end

  def map_data(locations)
    logger.info "Prepping map data with locations #{locations}"
    @map_points ||= {}
    default_cluster = Cluster.new(name: 'Unclustered', color: 'red', sequence: 0)
    locations.to_gmaps4rails do |loc, marker|
      logger.debug "Processing location #{loc}"
      cluster = loc.cluster || default_cluster
      @map_points[cluster] ||= {}

      letter = next_letter @map_points[cluster].keys.last

      @map_points[cluster][letter] = loc
      marker.infowindow render(partial: '/locations/infowindow', locals: {loc: loc})
      marker.json name: loc.name, address: loc.address, picture: marker_img_path(cluster.color, letter)
    end
  end

  def marker_img(color, letter)
    image_tag marker_img_path(color, letter)
  end

  def marker_img_path(color, letter)
    asset_path "map_markers/#{color}_Marker#{letter}.png"
  end

  def open_hours(location)
    result = ""
    if location.open_time || location.close_time
      result << location.open_time.strftime("%l:%M %p") if location.open_time
      result << (result.length > 0 ? " &mdash; " : " until ")
      result << location.close_time.strftime("%l:%M %p") if location.close_time
    end
    result.html_safe
  end
end
