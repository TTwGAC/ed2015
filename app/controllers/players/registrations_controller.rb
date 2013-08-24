class Players::RegistrationsController < Devise::RegistrationsController
  def create
    super
    if resource.persisted?
      event "create", :player, resource.id, description: "#{resource.name} registered as a new player"
      save_thirdparty_creds(resource, session)
    end
  end

  def update
    super
    if resource.persisted?
      event "update", :player, resource.id, description: "#{resource.name} updated his information"
      save_thirdparty_creds(resource, session)
    end
  end
end
