module LocationsHelper
  def map_data(locations)
    @map_points ||= {}
    default_cluster = Cluster.new(name: 'Unclustered', color: 'red')
    locations.to_gmaps4rails do |loc, marker|
      cluster = loc.cluster || default_cluster
      letter = if @map_points[cluster]
        @map_points[cluster].keys.last.next
      else
        @map_points[cluster] ||= {}
        'A'
      end
      @map_points[cluster][letter] = loc
      #marker.infowindow render_to_string partial: '/locations/infowindow', locals: {loc: loc}
      marker.json name: loc.name, address: loc.address, picture: marker_img_path(cluster.color, letter)
    end
  end

  def marker_img(color, letter)
    image_tag marker_img_path(color, letter)
  end

  def marker_img_path(color, letter)
    asset_path "map_markers/#{color}_Marker#{letter}.png"
  end
end
