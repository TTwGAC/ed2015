class Message < ActiveRecord::Base
  has_many :message_deliveries
  belongs_to :sender, foreign_key: :sender_id, class_name: 'Player'
  validates :sender, presence: true
  validates :text, presence: true
end
