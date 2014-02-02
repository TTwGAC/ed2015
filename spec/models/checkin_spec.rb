# encoding: utf-8
require 'spec_helper'

describe Checkin do
  let(:cluster) { FactoryGirl.create :cluster }
  let(:locA) { FactoryGirl.create :location_A, cluster: cluster }
  let(:locB) { FactoryGirl.create :location_B, cluster: cluster }
  let(:locC) { FactoryGirl.create :location_C, cluster: cluster }
  let(:puzzle_ending_at_C) { locC.destination_for_puzzles.first }
  let(:locD) { FactoryGirl.create :location_D, cluster: cluster, next_puzzle: puzzle_ending_at_C }
  let(:player) { FactoryGirl.create :player }

  before :each do
    FactoryGirl.reload
    [locA, locB, locC, locD, player] # Instantiate
  end

  it %q{should default the team when not specified} do
    opts = { player: player, location: locC }
    c = Checkin.create! opts
    c.team.should == player.team
  end

  it %q{should respect the team when specified} do
    team = FactoryGirl.create :otherteam
    opts = { player: player, team: team, location: locC }
    c = Checkin.create! opts
    c.team.should == team
  end

  describe '#find_or_create' do

    it %q{should return the existing Checkin if one for a given location already exists} do
      opts = { player: player, team: player.team, location: locC }
      c = Checkin.create! opts
      Checkin.find_or_create(opts).should == c
    end

  end

  describe '#select_next_puzzle' do
    describe 'with locations available in the current cluster' do

      it 'should select the next puzzle when one is specifically named' do
        checkin = Checkin.create! player: player, location: locD

        checkin.select_next_puzzle.should == puzzle_ending_at_C
      end

      it 'should select a puzzle from any location without a checkin in the current cluster' do
        Checkin.create! player: player, location: locD
        Checkin.create! player: player, location: locC
        checkin = Checkin.new player: player, location: locA
        checkin.valid?.should be true # populate checkin fields

        checkin.next_puzzle.should == locB.destination_for_puzzles.first
      end

    end

    describe 'with no locations available in the current cluster' do

      it 'should select a random puzzle from any location without a checkin in the next cluster'

      it 'should not choose a puzzle that has a specific location when the location does not specify it'

    end

  end

  describe '#previous' do
    it 'should return the previous checkin for the given team' do
      c = Checkin.create! player: player, location: locC
      b = Checkin.create! player: player, location: locB
      a = Checkin.create! player: player, location: locA
      a.previous.should == b
    end

    it 'should return nil if there is no previous checkin' do
      a = Checkin.create! player: player, location: locA
      a.previous.should be_nil
    end
  end
end
