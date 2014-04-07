# encoding: utf-8

class Hint < ActiveRecord::Base
  belongs_to :puzzle
  validates :hint, presence: true
  validates :suggested_penalty, presence: true
  delegate :name, to: :puzzle, prefix: true
  after_initialize :init

  def init
    self.suggested_penalty ||= 0
  end
end

# ## Schema Information
#
# Table name: `hints`
#
# ### Columns
#
# Name                     | Type               | Attributes
# ------------------------ | ------------------ | ---------------------------
# **`id`**                 | `integer`          | `not null, primary key`
# **`hint`**               | `text`             |
# **`puzzle_id`**          | `integer`          |
# **`suggested_penalty`**  | `integer`          |
# **`created_at`**         | `datetime`         | `not null`
# **`updated_at`**         | `datetime`         | `not null`
#
