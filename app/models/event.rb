class Event < ActiveRecord::Base
  validates_presence_of :player_id, :subject, :action
  belongs_to :player
end
