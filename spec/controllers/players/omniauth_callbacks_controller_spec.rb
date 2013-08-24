require 'spec_helper'

describe Players::OmniauthCallbacksController do
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
      pending "How to get the request.env loaded with the auth hash?"
      player = FactoryGirl.build(:player)
      player.facebook_uid = auth.uid
      player.save!
      Player.find_or_create_for_facebook_oauth(auth).should == player
    end

    it %q{should find and save a player who has NOT previously logged in via Facebook but has an existing account with the same email} do 
      pending "How to get the request.env loaded with the auth hash?"
      player = FactoryGirl.build(:player)
      player.email = auth.info.email
      player.save!
      found_player = Player.find_or_create_for_facebook_oauth(auth)
      found_player.should == player
      found_player.facebook_uid.should == auth.uid
    end

    it %q{should create a new player when no previous Facebook login and no matching email address} do
      pending "How to get the request.env loaded with the auth hash?"
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
