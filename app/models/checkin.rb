class Checkin < ActiveRecord::Base
  belongs_to :location
  belongs_to :team
  belongs_to :player
  before_save :get_team

  delegate :name, to: :location, prefix: true
  delegate :name, to: :team, prefix: true
  delegate :name, to: :player, prefix: true

  def next_puzzle
    raise "Record must be saved before getting the next puzzle!" unless persisted?

    return self.location.next_puzzle if self.location.next_puzzle

    cluster = location.cluster

    raise "Checked into a location not in a cluster!" unless cluster

    possible_locations = cluster.locations.select do |location|
      # Find any location in this cluster that the user has not checked into
      Checkin.where(team_id: self.team).where(location_id: location).none?
    end

    if possible_locations.any?
      return possible_locations.sample
    end

    next_cluster = cluster.next_cluster

    raise "Need to set up end-game mailer and notify Game Control" unless next_cluster

    next_cluster.locations.sample
  end

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

