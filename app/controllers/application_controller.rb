class ApplicationController < ActionController::Base
  before_filter :require_player_info
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to page_path('access_denied'), :alert => exception.message
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

  def event(action, subject, subject_id = nil, extra = {})
    if extra[:params] && !extra.has_key?(:description)
      extra[:description] = params.collect{|k,v| "#{k}: #{v}" }.join(", ")
    end
    player = signed_in? ? current_player : Player.first
    Event.create! player: player, subject: subject, subject_id: subject_id, action: action, description: extra[:description]
  end

  def save_thirdparty_creds(player, session)
    return unless session.has_key? 'auth_service'
    service = session['auth_service']
    return unless session[service]
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
    player.save!

    session.delete(:auth_service)
    session.delete(service)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit :first_name, :last_name, :email, :nickname, :password, :password_confirmation
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit :first_name, :last_name, :email, :nickname, :password, :password_confirmation, :current_password
    end
  end
end
