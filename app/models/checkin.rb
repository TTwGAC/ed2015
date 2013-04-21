class Checkin < ActiveRecord::Base
  attr_accessible :location_id, :timestamp
  belongs_to :location
end

# == Schema Information
#
# Table name: checkins
#
#  id          :integer          not null, primary key
#  timestamp   :datetime
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

