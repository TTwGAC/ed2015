class Document < ActiveRecord::Base
  belongs_to :documentable, polymorphic: true
  delegate :name, to: :documentable, prefix: true
  delegate :url, to: :file, prefix: true
  validates_presence_of :name

  before_save :get_token

  scope :for_players,      -> { where(private: false) }
  scope :for_game_control, -> { where(private: true)  }

  def get_token
    self.token ||= SecureRandom.hex(16)
  end

  mount_uploader :file, DocumentUploader
end

# == Schema Information
#
# Table name: documents
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  description       :text
#  token             :string(255)      not null
#  private           :boolean
#  file              :string(255)
#  documentable_id   :integer
#  documentable_type :string(255)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

