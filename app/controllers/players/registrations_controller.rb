class Players::RegistrationsController < Devise::RegistrationsController
  def create
    super
    persist_avatar
    if resource.persisted?
      event "create", :player, resource.id, description: "#{resource.name} registered as a new player"
      save_thirdparty_creds(resource, session['social']) if session['social']
      session.delete 'social'
    end
  end

  def update
    super
    persist_avatar
    if resource.persisted?
      event "update", :player, resource.id, description: "#{resource.name} updated his information"
      save_thirdparty_creds(resource, session)
    end
  end

  def persist_avatar
    if params['player']['avatar']
      @player.avatar = params['player']['avatar']
      unless @player.save
        flash[:error] = @player.errors.full_messages.first
      end
    end
  end
end
