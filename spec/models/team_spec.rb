require 'spec_helper'

describe Team do
  it "should disallow reserved team names" do
    expect { t = Team.create! name: 'Game Control'; puts "New team is valid: #{t.valid?}"  }.to raise_error
  end
end