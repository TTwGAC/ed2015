require 'spec_helper'

describe Event do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  player_id   :integer          not null
#  subject     :string(255)      not null
#  subject_id  :integer
#  action      :string(255)      not null
#  description :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

