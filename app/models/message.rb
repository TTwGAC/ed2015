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
  delegate :name, to: :sender, prefix: true

  before_validation :default_status

  def default_status
    self.status ||= 'draft'
  end

  def sendable?
    self.status == 'draft'
  end

  def destination_object
    klass, id = self.destination.split ':'
    valid_classes = %w(Team Player)
    if valid_classes.include? klass
      Kernel.const_get(klass).find(id)
    elsif id == 'everyone'
      OpenStruct.new name: 'Everyone'
    else
      OpenStruct.new name: "UNKNOWN OBJECT"
    end
  end

  def destination_name
    destination_object.name
  end

  def targets
    if sendable?
      obj = destination_object
      case obj
      when Team
        obj.players
      when Player
        [obj]
      else
        # Everyone
        Player.all.select &:playing?
      end
    else
      message_deliveries
    end
  end

end

# ## Schema Information
#
# Table name: `messages`
#
# ### Columns
#
# Name                 | Type               | Attributes
# -------------------- | ------------------ | ---------------------------
# **`id`**             | `integer`          | `not null, primary key`
# **`text`**           | `text`             |
# **`sender_id`**      | `integer`          |
# **`delivery_type`**  | `string(255)`      |
# **`status`**         | `string(255)`      |
# **`destination`**    | `string(255)`      |
# **`created_at`**     | `datetime`         |
# **`updated_at`**     | `datetime`         |
#
