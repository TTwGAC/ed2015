class Puzzle < ActiveRecord::Base
  STATUSES = [ '', 'wip', 'needs_testing', 'ready', 'disabled' ].freeze
  ACTIVE_STATUSES = ['ready', 'needs_testing'].freeze
  has_one :comes_from, class_name: "Location", foreign_key: 'next_puzzle_id'
  belongs_to :destination, class_name: "Location", foreign_key: 'destination_id'
  belongs_to :owner, class_name: 'Player', foreign_key: 'owner_id'
  has_many :documents, as: :documentable
  has_many :teams
  has_many :checkins, foreign_key: 'solved_puzzle_id'
  has_many :hints
  before_save :get_token
  delegate :name, to: :destination, prefix: true
  delegate :name, to: :owner, prefix: true
  delegate :for_players, :for_game_control, to: :documents, prefix: true
  delegate :next_puzzle, to: :location
  validates :name, presence: true
  validates :destination, uniqueness: true, allow_blank: true
  validates_inclusion_of :status, in: STATUSES, allow_blank: true

  scope :active, -> { where(status: ACTIVE_STATUSES) }

  def self.statuses
    STATUSES.inject({}) do |statuses, key|
      statuses[key] = status_name(key)
      statuses
    end
  end

  def active?
    ACTIVE_STATUSES.include? self.status
  end

  def self.status_name(name)
    case name
    when 'wip' then 'Work In Progress'
    when 'needs_testing' then 'In Testing'
    when 'ready' then 'Ready'
    when 'disabled' then 'DISABLED'
    else 'Unknown'
    end
  end

  def status_name
    self.class.status_name(self.status)
  end

  def get_token
    self.token ||= SecureRandom.hex(16)
  end

  def expected_ttc
    super || 0
  end

  def open?
    Checkin.where(solved_puzzle: self).count > 0
  end

  def num_checkins
    Checkin.where(solved_puzzle: self).count
  end

  def completed?
    num_teams = Team.playing.count
    num_checkins == num_teams
  end
end

# ## Schema Information
#
# Table name: `puzzles`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `integer`          | `not null, primary key`
# **`name`**             | `string(255)`      |
# **`destination_id`**   | `integer`          |
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
# **`token`**            | `string(255)`      |
# **`description`**      | `text`             |
# **`status`**           | `string(255)`      |
# **`flavortext`**       | `text`             |
# **`expected_ttc`**     | `integer`          |
# **`owner_id`**         | `integer`          |
# **`open`**             | `boolean`          |
# **`include_bearing`**  | `boolean`          |
#
