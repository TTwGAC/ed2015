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

    data = {}
    data['auth_service'] = 'twitter'
    data['twitter'] = {credentials: credentials, info: info}
    data['name'] = "@#{info[:twitter_handle]}"

    if player_signed_in?
      save_thirdparty_creds current_player, data
      flash_success data
      redirect_to '/'
    elsif player = Player.where({twitter_uid: auth.uid}).first
      social_login player, data
    else
      social_signup data
    end
  end

  def facebook
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

    data = {}
    data['auth_service'] = 'facebook'
    data['facebook'] = {credentials: credentials, info: info}
    data['name'] = "#{info[:first_name]} #{info[:last_name]}"

    if player_signed_in?
      save_thirdparty_creds current_player, data
      flash_success data
      redirect_to '/'
    elsif player = Player.where(facebook_uid: credentials[:facebook_uid]).first
      social_login player, data
    else
      social_signup data
    end
  end

  def flash_success(data)
    set_flash_message(:notice, :success, kind: data['auth_service'].capitalize, name: data['name']) if is_navigational_format?
  end

  def social_login(player, data)
    save_thirdparty_creds player, data
    if player.persisted?
      flash_success data
      sign_in_and_redirect player, :event => :authentication
    else
      session['social'] = data
      redirect_to edit_player_registration_url
    end
  end

  def social_signup(data)
    session['social'] = data
    flash_success data
    flash[:notice] = 'To complete registration, please fill out the form below'
    redirect_to new_player_registration_url
  end
end
