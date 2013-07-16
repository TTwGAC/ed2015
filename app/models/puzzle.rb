class Puzzle < ActiveRecord::Base
  belongs_to :location
  mount_uploader :document, PuzzleDocumentUploader
  before_save :get_token

  def get_token
    self.token ||= SecureRandom.hex(16)
  end
end
