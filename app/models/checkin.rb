class Checkin < ActiveRecord::Base
  class Error < StandardError; end

  belongs_to :location
  belongs_to :team
  belongs_to :player
  belongs_to :solved_puzzle, class_name: 'Puzzle', foreign_key: 'solved_puzzle_id'
  belongs_to :next_puzzle, class_name: 'Puzzle', foreign_key: 'next_puzzle_id'
  before_validation :update_links
  validates_presence_of :team, :player, :location
  after_save :notify_players

  delegate :name, to: :location, prefix: true
  delegate :name, to: :team, prefix: true
  delegate :name, to: :player, prefix: true
  delegate :name, :flavortext, :documents_for_players, to: :solved_puzzle, prefix: true
  delegate :name, :flavortext, :documents_for_players, to: :next_puzzle, prefix: true

  validates :location_id, presence: true, uniqueness: { scope: :team_id }
  validates :team_id, presence: true

  def self.find_or_create(opts)
    c = self.where(team_id: opts[:team], location_id: opts[:location]).first
    c || Checkin.create!(opts)
  end

  def timestamp
    super || self.created_at
  end

  def get_team
    self.team ||= self.player.team
    raise Error, 'Team is not active, checkin denied' unless self.team.playing?
    self.team
  end

  def update_links
    return true unless self.new_record?
    get_team
    set_location
    set_puzzle
    team.save!
  end

  def notify_players
    return true unless self.new_record?
    team.players.each do |player|
      mailer = TeamMailer.send_puzzle(player, self)
      mailer.deliver!
    end
  end

  def set_location
    if team.current_puzzle
      unless team.current_puzzle_destination == location
        raise Error.new("You can't check in here - you're at the wrong location!")
      end
    end
    team.location = location
  end

  def set_puzzle
    if self.solved_puzzle || self.next_puzzle
      logger.warn "NOT setting the puzzle because either solved: #{self.solved_puzzle.inspect} or next: #{self.next_puzzle.inspect}"
    end
    self.solved_puzzle = self.team.current_puzzle
    self.next_puzzle = select_next_puzzle
    self.team.current_puzzle = self.next_puzzle
  end

  def select_next_puzzle
    if location.next_puzzle
      raise Error, "Designated next puzzle is not ready - Contact Game Control" unless location.next_puzzle.active?
      return location.next_puzzle
    end

    cluster = location.cluster

    raise Error, "Checked into a location not in a cluster!" unless cluster

    possible_locations = filter_locations cluster.locations

    if possible_locations.any?
      next_location = possible_locations.sample
    else
      next_cluster = cluster.next_cluster

      raise "Need to set up end-game mailer and notify Game Control" unless next_cluster

      next_location = filter_locations(next_cluster.locations).sample
    end

    puzzle = next_location.destination_for_puzzle
    raise Error, "Selected next puzzle is not ready - Contact Game Control" unless puzzle.active?
    puzzle
  end

  def filter_locations(locations)
    locations.select do |location|
      not_current_location = (location != self.location)
      # Find any location in this cluster that the user has not checked into
      no_checkin = Checkin.where(team_id: self.team).where(location_id: location).none?
      if location.destination_for_puzzle
        has_puzzle = true
        no_chain = location.destination_for_puzzle.comes_from.nil?
      else
        has_puzzle = false
        no_chain = false
      end
      not_current_location && has_puzzle && no_chain && no_checkin && location.active?
    end
  end

  def previous
    last_checkin = Checkin.where(team_id: self.team).where('created_at < ?', created_at).order('created_at DESC').limit(1).first
    last_checkin == self ? nil : last_checkin
  end

  def solved_puzzle_expected_ttc
    if solved_puzzle
      solved_puzzle.expected_ttc
    else
      0
    end
  end

  def next_location
    next_puzzle.destination
  end

  def next_location_name
    next_puzzle.destination_name
  end

  def location_coordinates
    [location.latitude, location.longitude]
  end

  def next_location_coordinates
    [next_puzzle.destination.latitude, next_puzzle.destination.longitude]
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

