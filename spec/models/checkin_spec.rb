# encoding: utf-8
require 'spec_helper'

describe Checkin do
  let(:cluster) { FactoryGirl.create :cluster }
  let(:locA) { FactoryGirl.create :location_A, cluster: cluster }
  let(:locB) { FactoryGirl.create :location_B, cluster: cluster }
  let(:locC) { FactoryGirl.create :location_C, cluster: cluster }
  let(:puzzle_ending_at_C) { locC.destination_for_puzzle }
  let(:locD) { FactoryGirl.create :location_D, cluster: cluster, next_puzzle: puzzle_ending_at_C }
  let(:player) { FactoryGirl.create :player }

  def verify_puzzles(last_puzzle, next_puzzle, checkin, team)
    checkin.team.should == team

    checkin.next_puzzle.should_not == last_puzzle
    checkin.next_puzzle.should_not be nil

    checkin.solved_puzzle.should == last_puzzle
    checkin.next_puzzle.should == next_puzzle
    team.current_puzzle.should == next_puzzle

    # Ensure the changes are flushed
    team.changed?.should be false
  end

  def verify_location(location, checkin, team)
    checkin.location.should == location
    team.location.should == location
  end


  before :each do
    FactoryGirl.reload
    Checkin.delete_all
    [locA, locB, locC, locD, player] # Instantiate
    player.team.location = player.team.current_puzzle = nil
  end

  it %q{should raise if the current location is not in a cluster} do
    locA.cluster = nil
    expect { Checkin.find_or_create player: player, location: locA }.to raise_error Checkin::Error
  end

  it %q{should default the team when not specified} do
    opts = { player: player, location: locC }
    c = Checkin.find_or_create opts
    c.team.should == player.team
  end

  it %q{should respect the team when specified} do
    team = FactoryGirl.create :otherteam
    opts = { player: player, team: team, location: locC }
    c = Checkin.find_or_create opts
    c.team.should == team
  end

  it %q{should track the previous and next puzzles} do
    team = player.team

    # Process first checkin
    opts = { player: player, team: team, location: locB }
    c = Checkin.find_or_create opts

    verify_puzzles nil, c.next_puzzle, c, team
    verify_location locB, c, team

    # Process next checkin
    last_puzzle = c.next_puzzle
    next_location = last_puzzle.destination
    opts = { player: player, team: team, location: next_location }
    c = Checkin.find_or_create opts

    verify_puzzles last_puzzle, c.next_puzzle, c, team
    verify_location next_location, c, team
  end

  it %q{should track the previous and next puzzles without a specified team} do
    team = player.team

    # Process first checkin
    opts = { player: player, location: locB }
    c = Checkin.find_or_create opts

    verify_puzzles nil, c.next_puzzle, c, team
    verify_location locB, c, team

    # Process next checkin
    last_puzzle = c.next_puzzle
    next_location = last_puzzle.destination
    opts = { player: player, location: next_location }
    c = Checkin.find_or_create opts

    verify_puzzles last_puzzle, c.next_puzzle, c, team
    verify_location next_location, c, team
  end

  it %q{should deny the checkin if the team is not paid} do
    team = player.team
    team.paid = false
    opts = { player: player, location: locB }
    expect { Checkin.find_or_create opts }.to raise_error Checkin::Error
  end

  it %q{should deny the checkin if the team is not active} do
    team = player.team
    team.active = false
    opts = { player: player, location: locB }
    expect { Checkin.find_or_create opts }.to raise_error Checkin::Error
  end


  describe '#find_or_create' do

    it %q{should return the existing Checkin if one for a given location already exists} do
      opts = { player: player, team: player.team, location: locC }
      c = Checkin.find_or_create opts
      Checkin.find_or_create(opts).should == c
    end

  end

  describe '#select_next_puzzle' do
    describe 'with locations available in the current cluster' do

      it %q{should select the next puzzle when one is specifically named} do
        checkin = Checkin.find_or_create player: player, location: locD

        checkin.select_next_puzzle.should == puzzle_ending_at_C
      end

      it %q{should select a puzzle from any location without a checkin in the current cluster} do
        Checkin.find_or_create player: player, location: locD
        c1 = Checkin.find_or_create player: player, location: locC
        c2 = Checkin.new player: player, location: c1.next_puzzle.destination
        c2.valid?.should be true # populate checkin fields

        # Check that the selected next puzzle is one of the 2 possibilities
        [locB, locA].map(&:destination_for_puzzle).include?(c2.next_puzzle).should be true
      end

      it %q{should not include any location that has no puzzle} do
        # A: No Puzzle
        # B: Valid
        # C: checkin2
        # D: checkin1
        locA.destination_for_puzzle = nil
        locA.save!
        checkin1 = Checkin.find_or_create player: player, location: locD
        checkin2 = Checkin.new player: player, location: checkin1.next_puzzle.destination
        checkin2.valid?.should be true # populate checkin fields

        checkin2.next_puzzle.should == locB.destination_for_puzzle
      end

    end

    describe 'with no locations available in the current cluster' do

      it %q{should select a random puzzle from any location without a checkin in the next cluster}

      it %q{should not choose a puzzle that has a specific location when the location does not specify it}

    end

    describe 'with inactive locations' do
      it %q{should raise if the selected location with a next_puzzle in inactive} do
        locD.next_puzzle.status = 'wip'
        checkin = Checkin.new player: player, location: locD

        expect { checkin.valid? }.to raise_error Checkin::Error
      end

      it %q{should exclude locations whose puzzles are not active}
    end

  end

  describe '#previous' do
    it %q{should return the previous checkin for the given team} do
      d = Checkin.find_or_create player: player, location: locD
      c = Checkin.find_or_create player: player, location: d.next_puzzle.destination
      b = Checkin.find_or_create player: player, location: c.next_puzzle.destination
      b.previous.should == c
    end

    it %q{should return nil if there is no previous checkin} do
      a = Checkin.find_or_create player: player, location: locA
      a.previous.should be_nil
    end
  end

  describe 'scoping to active puzzles' do
    it %q{should only consider active puzzles} do
      puzzle_ending_at_C.status = 'wip'
      expect { Checkin.find_or_create player: player, location: locD }.to raise_error Checkin::Error
    end

    it %q{should raise if a location has a next_puzzle that is not ready}

  end
end

# ## Schema Information
#
# Table name: `checkins`
#
# ### Columns
#
# Name                    | Type               | Attributes
# ----------------------- | ------------------ | ---------------------------
# **`id`**                | `integer`          | `not null, primary key`
# **`timestamp`**         | `datetime`         |
# **`location_id`**       | `integer`          |
# **`created_at`**        | `datetime`         | `not null`
# **`updated_at`**        | `datetime`         | `not null`
# **`team_id`**           | `integer`          |
# **`player_id`**         | `integer`          |
# **`solved_puzzle_id`**  | `integer`          |
# **`next_puzzle_id`**    | `integer`          |
#
