class Players::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    auth = request.env["omniauth.auth"]
    credentials = {
      twitter_uid: auth.uid,
      twitter_token: auth.credentials.token,
      twitter_secret: auth.credentials.secret
    }
    info = {
      twitter_handle: auth.info.nickname
    }

    player = Player.where({twitter_uid: auth.uid}).first
    if player
      handle_callback "Twitter", player
    else
      session['auth_service'] = 'twitter'
      session['twitter'] = {credentials: credentials, info: info}
      set_flash_message(:success, :success, :kind => 'Twitter', :name => "@#{info[:twitter_handle]}") if is_navigational_format?
      flash[:notice] = 'To complete registration, please fill out the form below'
      redirect_to new_player_registration_url
    end
  end

  def facebook
    session['auth_service'] = 'facebook'
    auth = request.env["omniauth.auth"]
    credentials = {
      facebook_uid: auth.uid,
      facebook_token: auth.credentials.token
    }
    info = {
      email: auth.info.email,
      first_name: auth.extra.raw_info.first_name,
      last_name: auth.extra.raw_info.last_name,
    }

    session[:facebook] = {credentials: credentials, info: info}
    player = find_or_create
    handle_callback "Facebook", player
  end

  def find_or_create
    service = session['auth_service']
    return unless session.has_key? service
    credentials = session[service][:credentials]
    info        = session[service][:info]

    locator = {"#{service}_uid" => credentials["#{service}_uid".to_sym]}

    player = Player.where(locator).first
    unless player
      player = Player.where(email: info[:email]).first if info[:email]

      if player
        save_thirdparty_creds(player, session)
      else
        # Create a new Player
        player = Player.new({password: Devise.friendly_token}.merge(info))
        player.skip_confirmation!
        player.save!
        event "create", :player, player.id, description: "#{player.name} registered via #{service.titleize}"
      end
    end
    player
  end

  def handle_callback(service, player)
    if player.persisted?
      # TODO: Check for required information - redirect to edit screen if missing
      sign_in_and_redirect player, :event => :authentication
      set_flash_message(:notice, :success, :kind => service, :name => player.name) if is_navigational_format?
    else
      redirect_to new_player_registration_url
    end
  end
end
