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

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  first_name             :string(255)
#  last_name              :string(255)
#  nickname               :string(255)
#  created                :datetime
#  modified               :datetime
#  role                   :string(255)
#  team_id                :integer
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#

