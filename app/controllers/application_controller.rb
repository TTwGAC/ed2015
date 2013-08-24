class ApplicationController < ActionController::Base
  before_filter :require_player_info
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery

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

  def event(action, subject, subject_id = nil, extra = {})
    if extra[:params] && !extra.has_key?(:description)
      extra[:description] = params.collect{|k,v| "#{k}: #{v}" }.join(", ")
    end
    player = signed_in? ? current_player : Player.first
    Event.create! player: player, subject: subject, subject_id: subject_id, action: action, description: extra[:description]
  end

  def save_thirdparty_creds(service)
    credentials = session[service][:credentials]
    info        = session[service][:info]

    # Link the existing player to this account
    credentials.keys.each do |key|
      player[key] = credentials[key]
    end

    info.keys.each do |key|
      # Prefer info already in our database
      player[key] ||= info[key]
    end
  def configure_permitted_parameters
    # :email, :password, :password_confirmation allowed by default in Devise
    [:first_name, :last_name, :nickname].each do |param|
      devise_parameter_sanitizer.for(:sign_up) << param
      devise_parameter_sanitizer.for(:account_update) << param
    end
  end
end
