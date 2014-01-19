class Puzzle < ActiveRecord::Base
  belongs_to :location
  has_many :documents, as: :documentable
  before_save :get_token
  delegate :name, to: :location, prefix: true
  delegate :for_players, :for_game_control, to: :documents, prefix: true

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

