# encoding: utf-8
require 'spec_helper'

describe Location do
  let(:location) { FactoryGirl.create :location_A }

  before :each do
    FactoryGirl.reload
  end

  it %q{should be active when it has a puzzle and that puzzle is active} do
    location.destination_for_puzzle.status = 'ready'
    location.active?.should be true
  end

  it %q{should not be active when it does not have a puzzle} do
    location.destination_for_puzzle = nil
    location.active?.should be false
  end

  it %q{should not be active when its puzzle is inactive} do
    location.destination_for_puzzle.status = 'wip'
    location.active?.should be false
  end
end
