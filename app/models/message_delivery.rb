class MessageDelivery < ActiveRecord::Base
  STATUSES = %w{queued sent error}
  belongs_to :message
  belongs_to :player
  validates :message, presence: true
  validates :destination, presence: true
  validates :status, inclusion: { in: STATUSES }, presence: true
  delegate :name, to: :player, prefix: true
end
