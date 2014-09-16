require 'spec_helper'

describe ApplicationController do
  include ControllerSpecMixin
  before :each do
    sign_in_as :player
  end

  describe '#event' do
    it %q{should create a new event} do
      Event.should_receive(:create).once.with(player: @current_player, action: 'foo', subject: 'bar', subject_id: 1, description: 'test')
      event 'foo', 'bar', 1, description: 'test'
    end

    it %q{should create a description based on supplied params} do
      Event.should_receive(:create).once.with(player: @current_player, action: 'foo', subject: 'bar', subject_id: 1, description: 'a: bc, d: ef')
      event 'foo', 'bar', 1, params: {'a' => 'bc', 'd' => 'ef'}
    end
  end
end

