class HomeController < ApplicationController
  def index
    if can? :manage, :all
      @map_data = Location.all.to_gmaps4rails do |loc, marker|
        marker.infowindow render_to_string partial: '/locations/infowindow', locals: {loc: loc}
        marker.picture({
          width:  32,
          height: 32,
          picture: "http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=#{loc.teams.count}|99FF99|000000"
        })
      end
    end
  end
end
