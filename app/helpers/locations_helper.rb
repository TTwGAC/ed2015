module LocationsHelper
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
    @map_points ||= {}
    default_cluster = Cluster.new(name: 'Unclustered', color: 'red', sequence: 0)
    locations.to_gmaps4rails do |loc, marker|
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
