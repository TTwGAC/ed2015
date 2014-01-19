class Document < ActiveRecord::Base
  belongs_to :documentable, polymorphic: true
  delegate :name, to: :documentable, prefix: true
  delegate :url, to: :file, prefix: true

  before_save :get_token

  scope :for_players,      -> { where(private: false) }
  scope :for_game_control, -> { where(private: true)  }

  def get_token
    self.token ||= SecureRandom.hex(16)
  end

  mount_uploader :file, DocumentUploader
end
