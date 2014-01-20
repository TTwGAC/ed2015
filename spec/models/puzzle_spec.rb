require 'spec_helper'

describe Puzzle do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
#
# Table name: puzzles
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  destination_id :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  token          :string(255)
#  origin_id      :integer
#  description    :text
#

