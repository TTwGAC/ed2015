class ApplicationController < ActionController::Base
  before_filter :require_player_info
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = exception.message
    respond_to do |format|
      format.html { render 'pages/access_denied', status: 403 }
    end
  end

  def current_user
    current_player
  end

  def require_player_info
    if current_player
      unless devise_controller?
        redirect_to edit_player_registration_path(current_player) unless current_player.has_required_fields?
      end
    end
  end

  def after_sign_in_path_for(resource)
    if current_player.team.playing? && Game.instance.status == 'running'
      '/dashboard'
    else
      sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
      if request.referer == sign_in_url
        super
      else
        stored_location_for(resource) || request.referer || root_path
      end
    end
  end

  def event(action, subject, subject_id = nil, extra = {})
    if extra[:params] && !extra.has_key?(:description)
      extra[:description] = params.collect{|k,v| "#{k}: #{v}" }.join(", ")
    end
    player = signed_in? ? current_player : Player.first
    Event.create! player: player, subject: subject, subject_id: subject_id, action: action, description: extra[:description]
  end

  def save_thirdparty_creds(player, data)
    return unless data.has_key? 'auth_service'
    service = data['auth_service']
    return unless data[service]
    credentials = data[service][:credentials]
    info        = data[service][:info]

    # Link the existing player to this account
    credentials.keys.each do |key|
      player[key] = credentials[key]
    end

    info.keys.each do |key|
      # Prefer info already in our database
      player[key] ||= info[key]
    end
    player.save
  end

  def configure_permitted_parameters
    params = [:first_name, :last_name, :email, :phone, :nickname, :password, :password_confirmation]
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit *params
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit *params, :current_password
    end
  end
end
