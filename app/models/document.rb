class Document < ActiveRecord::Base
  belongs_to :documentable, polymorphic: true

  before_save :get_token

  def get_token
    self.token ||= SecureRandom.hex(16)
  end

  mount_uploader :document, DocumentUploader
end
