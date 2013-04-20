class Checkin < ActiveRecord::Base
  attr_accessible :location_id, :timestamp
  belongs_to :location
end
