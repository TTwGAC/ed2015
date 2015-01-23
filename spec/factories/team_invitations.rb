FactoryGirl.define do
  factory :team_invitation do
    id 999
    email "jane@newyorkcity.us"
    team
    token "1LK4" * 5
  end
end

# ## Schema Information
#
# Table name: `team_invitations`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`player_id`**   | `integer`          |
# **`team_id`**     | `integer`          |
# **`email`**       | `string(255)`      |
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
# **`token`**       | `string(255)`      |
#
