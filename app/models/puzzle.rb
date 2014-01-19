class Puzzle < ActiveRecord::Base
  belongs_to :location
  mount_uploader :document, PuzzleDocumentUploader
  before_save :get_token
  delegate :name, to: :location, prefix: true

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
#  document    :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  token       :string(255)
#

