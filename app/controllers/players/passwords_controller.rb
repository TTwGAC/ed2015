class Players::PasswordsController < Devise::PasswordsController
  def resource_params
    params.require(:player).permit(:email, :password, :password_confirmation, :reset_password_token)
  end
  private :resource_params
end
