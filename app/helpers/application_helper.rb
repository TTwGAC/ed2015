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
end
