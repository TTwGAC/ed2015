class Message < ActiveRecord::Base
  STATUSES          = %w(draft sent)
  DELIVERY_TYPES    = %w(sms email phone)

  has_many :message_deliveries
  belongs_to :sender, foreign_key: :sender_id, class_name: 'Player'
  validates :sender, presence: true
  validates :text, presence: true
  validates :delivery_type, inclusion: { in: DELIVERY_TYPES }, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :destination, presence: true

  before_validation :default_status

  def default_status
    self.status ||= 'draft'
  end

end
