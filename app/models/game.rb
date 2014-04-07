class Game < ActiveRecord::Base
  acts_as_singleton

  STATUSES = %w[ pregame running closing closed ]

  def self.statuses
    STATUSES.inject({}) do |statuses, key|
      statuses[key] = status_name(key)
      statuses
    end
  end

  def self.status_name(key)
    case key
    when 'pregame' then 'Pre-Game'
    when 'running' then 'Game On!'
    when 'closing' then 'Closing Down'
    when 'closed'  then 'Game Over'
    end
  end

  def status_name
    self.class.status_name(self.status)
  end

end

# ## Schema Information
#
# Table name: `games`
#
# ### Columns
#
# Name                | Type               | Attributes
# ------------------- | ------------------ | ---------------------------
# **`id`**            | `integer`          | `not null, primary key`
# **`name`**          | `string(255)`      |
# **`status`**        | `string(255)`      |
# **`created_at`**    | `datetime`         | `not null`
# **`updated_at`**    | `datetime`         | `not null`
# **`hotline_open`**  | `boolean`          |
#
