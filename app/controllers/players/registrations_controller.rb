class Players::RegistrationsController < Devise::RegistrationsController
  def resource_params
    params.require(:player).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end
  private :resource_params
end
