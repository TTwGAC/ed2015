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

  def resource_params
    params.require(:player).permit(:first_name, :last_name, :email, :nickname, :password, :password_confirmation, :current_password)
  end
  private :resource_params
end
