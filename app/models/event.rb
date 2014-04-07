class Event < ActiveRecord::Base
  validates_presence_of :player_id, :subject, :action
  belongs_to :player
end

# ## Schema Information
#
# Table name: `events`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `integer`          | `not null, primary key`
# **`player_id`**    | `integer`          | `not null`
# **`subject`**      | `string(255)`      | `not null`
# **`subject_id`**   | `integer`          |
# **`action`**       | `string(255)`      | `not null`
# **`description`**  | `string(255)`      |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
#
