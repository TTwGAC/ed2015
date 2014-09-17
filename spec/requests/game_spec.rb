require 'spec_helper'

describe GameController, type: :controller do
  include ControllerSpecMixin

  describe "GET /game" do
    it "redirect access to unauthenticated players" do
      get game_path
      response.status.should be(302)
    end

    it "deny access to authenticated, non-admin players" do
      pending "Devise sign_in for request specs seems broken"
      sign_in_as :player
      get game_path
      response.status.should be(401)
    end


    it "allows access to authenticated admins" do
      pending "Devise sign_in for request specs seems broken"
      sign_in_as :admin
      get game_path
      response.status.should be(200)
    end
  end
end
