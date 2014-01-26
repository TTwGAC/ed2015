class Checkin < ActiveRecord::Base
  belongs_to :location
  belongs_to :team
  belongs_to :player
  before_validation :update_links

  delegate :name, to: :location, prefix: true
  delegate :name, to: :team, prefix: true
  delegate :name, to: :player, prefix: true

  validates_uniqueness_of :location_id, scope: :team_id

  def self.find_or_create(opts)
    c = self.where(team_id: opts[:team], location_id: opts[:location]).first
    c || Checkin.create!(opts)
  end

  def timestamp
    super || self.created_at
  end

  def get_team
    self.team ||= self.player.team
  end

  def update_links
    get_team
    set_location
  end

  def set_location
    team.location = location
    team.save!
  end

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

  def previous
    last_checkin = Checkin.where(team_id: self.team).order('created_at DESC').limit(2).last
    last_checkin == self ? nil : last_checkin
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

