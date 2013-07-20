class Players::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def handle_callback(service)
    if @player.persisted?
      # Skip email for OAuth logins
      @player.confirm!

      # TODO: Check for required information - redirect to edit screen if missing
      sign_in_and_redirect @player, :event => :authentication
      set_flash_message(:notice, :success, :kind => service) if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_player_registration_url
    end
  end

  def twitter
    # You need to implement the method below in your model (e.g. app/models/player.rb)
    @player = Player.find_or_create_for_twitter_oauth(request.env["omniauth.auth"], current_player)
    handle_callback "Twitter"
  end

  def facebook
    # You need to implement the method below in your model (e.g. app/models/player.rb)
    @player = Player.find_or_create_for_facebook_oauth(request.env["omniauth.auth"], current_player)
    handle_callback "Facebook"
  end

  def passthru(provider)
    raise "WTF"
  end
end
