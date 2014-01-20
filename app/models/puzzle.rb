class Puzzle < ActiveRecord::Base
  belongs_to :origin, class_name: "Location", foreign_key: 'origin_id'
  belongs_to :destination, class_name: "Location", foreign_key: 'destination_id'
  has_many :documents, as: :documentable
  before_save :get_token
  delegate :name, to: :origin, prefix: true
  delegate :name, to: :destination, prefix: true
  delegate :for_players, :for_game_control, to: :documents, prefix: true
  validates_presence_of :name

  def get_token
    self.token ||= SecureRandom.hex(16)
  end
end

# == Schema Information
#
# Table name: puzzles
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  token       :string(255)
#

