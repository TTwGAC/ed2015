class MessageDelivery < ActiveRecord::Base
  belongs_to :message
  validates :message, presence: true
  validates :destination, presence: true
end
