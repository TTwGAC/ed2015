# encoding: utf-8
require 'spec_helper'

describe Checkin do
  describe '#next_puzzle' do
    let(:cluster) { FactoryGirl.build :blue_cluster }
    let(:locA) { FactoryGirl.build :location_A }
    let(:locB) { FactoryGirl.build :location_B }
    let(:locC) { FactoryGirl.build :location_C }
    let(:loc_with_puzzle) { FactoryGirl.build :location_with_next_puzzle }
    let(:player) { FactoryGirl.build :player }

    before :each do
      [cluster, locA, locB, locC, loc_with_puzzle, player] # Instantiate
      locA.cluster = cluster; locA.save!
      locB.cluster = cluster; locB.save!
      locC.cluster = cluster; locC.save!
      loc_with_puzzle.cluster = cluster; loc_with_puzzle.save!
    end

    after :each do
      Checkin.delete_all
    end

    describe 'with locations available in the current cluster' do

      it "should raise if the checkin is not persisted" do
        checkin = Checkin.new player: player, location: locA
        expect { checkin.next_puzzle }.to raise_error
      end

      it 'should select the next puzzle when one is specifically named' do
        checkin = Checkin.create! player: player, location: loc_with_puzzle 

        checkin.next_puzzle.should == loc_with_puzzle.next_puzzle
      end

      it 'should select a puzzle from any location without a checkin in the current cluster' do
        Checkin.create! player: player, location: locA
        Checkin.create! player: player, location: loc_with_puzzle
        checkin = Checkin.create! player: player, location: locB

        checkin.next_puzzle.should == locC
      end

    end

    describe 'with no locations available in the current cluster' do

      it 'should select a random puzzle from any location without a checkin in the next cluster'

    end

  end
end
