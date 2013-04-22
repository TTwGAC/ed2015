require 'spec_helper'

describe User do
  it "should set the role based on the team name" do
    u = FactoryGirl.build(:user)
    u.team = Team.first conditions: {name: "Game Control"}
    u.role.should == "admin"

    u = FactoryGirl.build(:user)
    u.team = Team.first conditions: {name: "Observers"}
    u.role.should == "observer"

    u = FactoryGirl.build(:user)
    t = FactoryGirl.build(:team)
    u.team = t
    u.role.should == "player"
  end

  it "should automatically join the Observers team" do
    u = User.create! first_name: "Foo", last_name: "Bar", nickname: "Foobar", email: 'foo@bar.com', password: 'asdfghj'
    u.reload
    u.team.should == Team.first(conditions: {name: "Observers"})
  end
end