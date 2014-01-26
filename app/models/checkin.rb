class Checkin < ActiveRecord::Base
  belongs_to :location
  belongs_to :team
  belongs_to :player
  before_save :get_team

  delegate :name, to: :location, prefix: true
  delegate :name, to: :team, prefix: true
  delegate :name, to: :player, prefix: true

  def get_team
    self.team = player.team
  end
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
#  team_id     :integer
#  player_id   :integer
#

