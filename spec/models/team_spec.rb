require 'spec_helper'

describe Team do
  it "should disallow reserved team names" do
    expect { t = Team.create! name: 'Game Control' }.to raise_error
  end

  it "should have the default teams defined" do
    Team.where(name: "Game Control").should_not be_empty
    Team.where(name: "Observers").should_not be_empty
  end

  it "should create a random team secret on creation" do
    t = Team.create! name: 'random team secret test'
    t.reload
    t.token.should_not be_empty
  end
end

# == Schema Information
#
# Table name: teams
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  name        :string(255)
#  created     :datetime
#  updated     :datetime
#  description :text
#  slogan      :string(255)
#  logo        :string(255)
#  token       :string(255)
#

