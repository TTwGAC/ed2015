class Players::RegistrationsController < Devise::RegistrationsController
  after_filter :add_account

  def is_new_account?
    !resource.id
  end

  def add_account
    if resource.persisted? # user is created successfuly
      if is_new_account?
        event "create", :player, resource.id, description: "#{resource.name} registered as a new player"
      else
        event "update", :player, resource.id, description: "#{resource.name} updated his information"
      end
    end
  end
  protected :add_account

end
