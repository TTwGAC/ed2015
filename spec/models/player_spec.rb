require 'spec_helper'
require 'ostruct'

describe Player do
  it "should set the role to admin when on the Game Control team" do
    u = FactoryGirl.build(:player)
    u.team = Team.first conditions: {name: "Game Control"}
    u.role.should == "admin"
  end

  it "should set the role to observer when on the Observers team" do
    u = FactoryGirl.build(:player)
    u.team = Team.first conditions: {name: "Observers"}
    u.role.should == "observer"
  end

  it "should set the role to player when on any other team" do
    u = FactoryGirl.build(:player)
    t = FactoryGirl.build(:team)
    u.team = t
    u.role.should == "player"
  end

  it "should set the role to none when not a real player" do
    u = Player.new
    u.role.should == "none"
  end

  it "should automatically join the Observers team" do
    u = Player.create! first_name: "Foo", last_name: "Bar", nickname: "Foobar", email: 'foo@bar.com', password: 'asdfghj'
    u.reload
    u.team.should == Team.first(conditions: {name: "Observers"})
  end

  describe "using Facebook auth" do
    let(:auth) do
      OpenStruct.new(
        uid: 'fb-abcd1234',
        credentials: OpenStruct.new(token: 'zyxwvut4321'),
        info: OpenStruct.new(email: 'test@facebook.com'),
        extra: OpenStruct.new(
          raw_info: OpenStruct.new(
            first_name: 'Facebook',
            last_name: 'Test'
          )
        )
      )
    end

    it %q{should find a player who has previously logged in via Facebook} do
      player = FactoryGirl.build(:player)
      player.facebook_uid = auth.uid
      player.save!
      Player.find_or_create_for_facebook_oauth(auth).should == player
    end

    it %q{should find and save a player who has NOT previously logged in via Facebook but has an existing account with the same email} do 
      player = FactoryGirl.build(:player)
      player.email = auth.info.email
      player.save!
      found_player = Player.find_or_create_for_facebook_oauth(auth)
      found_player.should == player
      found_player.facebook_uid.should == auth.uid
    end

    it %q{should create a new player when no previous Facebook login and no matching email address} do
      found_player = Player.find_or_create_for_facebook_oauth(auth)
      found_player.first_name.should == 'Facebook'
      found_player.last_name.should == 'Test'
      found_player.email.should == 'test@facebook.com'
      found_player.persisted?.should be true
      found_player.nickname.should be nil
    end

  end

  describe "using Twitter auth" do
    let(:auth) do
      OpenStruct.new(
        uid: 'twitter-abcd1234',
        credentials: OpenStruct.new(
          token: 'zyxwvut4321',
          secret: 'lkjhgfdsa'
        ),
        info: OpenStruct.new(nickname: 'tweetastic')
      )
    end

    it %q{should find a player who has previously logged in via Twitter}
    it %q{should find a player who has NOT previously logged in via Twitter but has an existing account with the same email}
    it %q{should create a new player when no previous Twitter login and no matching email address}
  end

end

# == Schema Information
#
# Table name: players
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
#  avatar                 :string(255)
#

