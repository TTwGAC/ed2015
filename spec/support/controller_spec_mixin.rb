require 'spec_helper'

module ControllerSpecMixin
  def sign_in_as(type)
    @request.env["devise.mapping"] = Devise.mappings[:player]
    @current_player = FactoryGirl.build(type)
    @current_player.confirm!
    sign_in @current_player
  end

end
