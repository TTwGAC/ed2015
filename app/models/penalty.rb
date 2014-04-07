class Penalty < ActiveRecord::Base
  belongs_to :team
  belongs_to :assigner, class_name: 'Player', foreign_key: 'assigner_id'
  belongs_to :puzzle
  delegate :name, to: :team, prefix: true
  delegate :name, to: :assigner, prefix: true
  delegate :name, to: :puzzle, prefix: true
  validates :team_id, presence: true
  validates :assigner_id, presence: true
  validates :description, presence: true
  validates :minutes, presence: true
  after_initialize :init

  def init
    self.minutes ||= 0
  end
end

# ## Schema Information
#
# Table name: `penalties`
#
# ### Columns
#
# Name               | Type               | Attributes
# ------------------ | ------------------ | ---------------------------
# **`id`**           | `integer`          | `not null, primary key`
# **`team_id`**      | `integer`          |
# **`assigner_id`**  | `integer`          |
# **`puzzle_id`**    | `integer`          |
# **`description`**  | `text`             |
# **`minutes`**      | `integer`          |
# **`created_at`**   | `datetime`         | `not null`
# **`updated_at`**   | `datetime`         | `not null`
#
