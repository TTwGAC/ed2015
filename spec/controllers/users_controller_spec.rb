require 'spec_helper'

describe UsersController do
  render_views

  it "should find a user" do
    user = FactoryGirl.build(:user)
    user.role.should == 'observer'
  end

end