class Location < ActiveRecord::Base
  belongs_to :next_puzzle, class_name: 'Puzzle', foreign_key: 'next_puzzle_id'
  has_one :destination_for_puzzle, class_name: 'Puzzle', foreign_key: 'destination_id'
  has_many :teams
  has_many :checkins
  has_many :documents, as: :documentable
  belongs_to :cluster
  before_save :get_token
  delegate :name, :color, to: :cluster, prefix: true
  delegate :for_players, :for_game_control, to: :documents, prefix: true
  delegate :name, to: :next_puzzle, prefix: true
  delegate :name, to: :destination_for_puzzle, prefix: true
  acts_as_gmappable :process_geocoding => :geocode?, :normalized_address => "address",
                    :lat => 'latitude', :lng => "longitude"
  validates_presence_of :name

  def geocode?
    (!address.blank? && (latitude.blank? || longitude.blank?)) || address_changed?
  end

  def active?
    !!(destination_for_puzzle && destination_for_puzzle.active?)
  end

  def gmaps4rails_address
    self.address
  end

  def get_token
    self.token ||= SecureRandom.hex(16)
  end

  def open?
    Checkin.where(location: self).count > 0
  end

  def num_checkins
    Checkin.where(location: self).count
  end

  def completed?
    num_teams = Team.playing.count
    num_checkins == num_teams
  end
end

# ## Schema Information
#
# Table name: `locations`
#
# ### Columns
#
# Name                       | Type               | Attributes
# -------------------------- | ------------------ | ---------------------------
# **`id`**                   | `integer`          | `not null, primary key`
# **`address`**              | `string(255)`      |
# **`latitude`**             | `float`            |
# **`longitude`**            | `float`            |
# **`created_at`**           | `datetime`         | `not null`
# **`updated_at`**           | `datetime`         | `not null`
# **`name`**                 | `string(255)`      |
# **`token`**                | `string(255)`      |
# **`cluster_id`**           | `integer`          |
# **`permission_received`**  | `boolean`          |
# **`open_time`**            | `time`             |
# **`close_time`**           | `time`             |
# **`next_puzzle_id`**       | `integer`          |
#
