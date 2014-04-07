class Redirect < ActiveRecord::Base
  validates :token, presence: true
  validates :name, presence: true
  validates :destination_url, presence: true, format: { with: URI::regexp(%w(http https)) }
end

# ## Schema Information
#
# Table name: `redirects`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `integer`          | `not null, primary key`
# **`token`**            | `string(255)`      |
# **`name`**             | `string(255)`      |
# **`destination_url`**  | `string(255)`      |
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
#
