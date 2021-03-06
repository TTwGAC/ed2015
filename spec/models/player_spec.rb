require 'spec_helper'
require 'ostruct'

describe Player do
  it "should set the role to admin when on the Game Control team" do
    u = FactoryGirl.build(:player)
    u.team = Team.where(name: "Game Control").first
    u.role.should == "admin"
  end

  it "should set the role to observer when on the Observers team" do
    u = FactoryGirl.build(:player)
    u.team = Team.where(name: "Observers").first
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
    u = Player.create! first_name: "Foo", last_name: "Bar", nickname: "Foobar", email: 'foo@bar.com', password: 'asdfghj', phone: '2125551234'
    u.reload
    u.team.should == Team.where(name: "Observers").first
  end

end

# ## Schema Information
#
# Table name: `players`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`email`**                   | `string(255)`      | `default(""), not null`
# **`encrypted_password`**      | `string(255)`      | `default(""), not null`
# **`reset_password_token`**    | `string(255)`      |
# **`reset_password_sent_at`**  | `datetime`         |
# **`remember_created_at`**     | `datetime`         |
# **`sign_in_count`**           | `integer`          | `default(0)`
# **`current_sign_in_at`**      | `datetime`         |
# **`last_sign_in_at`**         | `datetime`         |
# **`current_sign_in_ip`**      | `string(255)`      |
# **`last_sign_in_ip`**         | `string(255)`      |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
# **`first_name`**              | `string(255)`      |
# **`last_name`**               | `string(255)`      |
# **`nickname`**                | `string(255)`      |
# **`created`**                 | `datetime`         |
# **`modified`**                | `datetime`         |
# **`role`**                    | `string(255)`      |
# **`team_id`**                 | `integer`          |
# **`confirmation_token`**      | `string(255)`      |
# **`confirmed_at`**            | `datetime`         |
# **`confirmation_sent_at`**    | `datetime`         |
# **`unconfirmed_email`**       | `string(255)`      |
# **`avatar`**                  | `string(255)`      |
# **`facebook_uid`**            | `string(255)`      |
# **`facebook_token`**          | `string(255)`      |
# **`twitter_uid`**             | `string(255)`      |
# **`twitter_token`**           | `string(255)`      |
# **`twitter_secret`**          | `string(255)`      |
# **`twitter_handle`**          | `string(255)`      |
# **`phone`**                   | `string(255)`      |
#
# ### Indexes
#
# * `index_users_on_confirmation_token` (_unique_):
#     * **`confirmation_token`**
# * `index_users_on_email` (_unique_):
#     * **`email`**
# * `index_users_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
#
