class Puzzle < ActiveRecord::Base
  STATUSES = [ '', 'wip', 'needs_testing', 'ready' ].freeze
  belongs_to :origin, class_name: "Location", foreign_key: 'origin_id'
  belongs_to :destination, class_name: "Location", foreign_key: 'destination_id'
  has_many :documents, as: :documentable
  before_save :get_token
  delegate :name, to: :origin, prefix: true
  delegate :name, to: :destination, prefix: true
  delegate :for_players, :for_game_control, to: :documents, prefix: true
  #delegate :next_puzzle, to: :location
  validates_presence_of :name
  validates_inclusion_of :status, in: STATUSES

  def self.statuses
    STATUSES.inject({}) do |statuses, key|
      statuses[key] = status_name(key)
      statuses
    end
  end

  def self.status_name(name)
    case name
    when 'wip' then 'Work In Progress'
    when 'needs_testing' then 'Needs Testing'
    when 'ready' then 'Ready'
    else 'Unknown'
    end
  end

  def status_name
    self.class.status_name(self.status)
  end

  def get_token
    self.token ||= SecureRandom.hex(16)
  end
end

# == Schema Information
#
# Table name: puzzles
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  destination_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  token          :string(255)
#  origin_id      :integer
#  description    :text
#

