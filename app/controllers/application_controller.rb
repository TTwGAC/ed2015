class ApplicationController < ActionController::Base
  before_filter :require_player_info
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
end
