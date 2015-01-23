require 'spec_helper'

describe ApplicationController do
  include ControllerSpecMixin
  before :each do
    sign_in_as :player
  end

  describe '#event' do
    after(:each) { Event.delete_all }

    it %q{should create a new event} do
      subject.event 'foo', 'bar', 1, description: 'test'
      e = Event.first
      e.player.should == subject.current_player
      e.action.should == 'foo'
      e.subject.should == 'bar'
      e.subject_id.should == 1
      e.description.should == 'test'
    end

    it %q{should create a description based on supplied params} do
      subject.event 'foo', 'bar', 1, params: {'a' => 'bc', 'd' => 'ef'}
      e = Event.first
      e.player.should == subject.current_player
      e.action.should == 'foo'
      e.subject.should == 'bar'
      e.subject_id.should == 1
      e.description.should == 'a: bc, d: ef'
    end
  end
end

