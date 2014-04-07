class MessageDelivery < ActiveRecord::Base
  STATUSES = %w{queued sent error}
  belongs_to :message
  belongs_to :player
  validates :message, presence: true
  validates :destination, presence: true
  validates :status, inclusion: { in: STATUSES }, presence: true
  delegate :name, to: :player, prefix: true
end

# ## Schema Information
#
# Table name: `message_deliveries`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `integer`          | `not null, primary key`
# **`message_id`**   | `integer`          |
# **`player_id`**    | `integer`          |
# **`destination`**  | `string(255)`      |
# **`status`**       | `string(255)`      |
# **`created_at`**   | `datetime`         |
# **`updated_at`**   | `datetime`         |
#
