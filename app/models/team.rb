class Team < ActiveRecord::Base

  RESERVED_NAMES = [
    "Game Control",
    "Observers"
  ].map {|team| team.downcase}

  validates :name, :presence => true, :uniqueness => {:case_sensitive => false}
  validates_plausible_phone :phone, presence: true
  before_save :default_values
  before_destroy :reset_members_to_observers
  has_many :players
  has_many :team_invitations
  has_many :checkins
  has_many :penalties
  belongs_to :location
  belongs_to :current_puzzle, class_name: 'Puzzle', foreign_key: 'current_puzzle_id'
  mount_uploader :logo, LogoUploader
  phony_normalize :phone, :default_country_code => 'US'
  delegate :name, to: :location, prefix: true
  delegate :name, :destination, to: :current_puzzle, prefix: true
  scope :player, -> { where(['LOWER(name) NOT IN (?)', RESERVED_NAMES]) }
  scope :playing, -> { player.where(paid: true, active: true) }

  def default_values
    default_active
    create_token
  end

  def default_active
    self.active = true if self.active.nil?
  end

  def create_token
    self.token ||= SecureRandom.hex(12)
  end

  def reset_members_to_observers
    observers = Team.where(name: 'Observers').first
    self.players.each do |player|
      player.team = observers
      player.save!
    end
  end

  def playing?
    paid && active
  end

  def score
    @score ||= calculate_score
  end

  def calculate_score
    puzzles_score = checkins.inject(0) do |total, checkin|
      total += checkin.solved_puzzle_expected_ttc
    end
    total_penalties = penalties.inject(0) do |total, p|
      total += p.minutes
    end

    puzzles_score - total_penalties
  end

  def reasons_not_playing
    reasons = []
    reasons << "Not Paid" unless paid
    reasons << "Not Active" unless active
    reasons
  end

end

# ## Schema Information
#
# Table name: `teams`
#
# ### Columns
#
# Name                     | Type               | Attributes
# ------------------------ | ------------------ | ---------------------------
# **`id`**                 | `integer`          | `not null, primary key`
# **`created_at`**         | `datetime`         | `not null`
# **`updated_at`**         | `datetime`         | `not null`
# **`name`**               | `string(255)`      |
# **`created`**            | `datetime`         |
# **`updated`**            | `datetime`         |
# **`description`**        | `text`             |
# **`slogan`**             | `string(255)`      |
# **`logo`**               | `string(255)`      |
# **`token`**              | `string(255)`      |
# **`phone`**              | `string(255)`      |
# **`paid`**               | `boolean`          |
# **`location_id`**        | `integer`          |
# **`current_puzzle_id`**  | `integer`          |
# **`active`**             | `boolean`          |
#
# ### Indexes
#
# * `index_teams_on_name` (_unique_):
#     * **`name`**
#
