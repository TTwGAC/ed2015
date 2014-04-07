# encoding: utf-8
require 'spec_helper'

describe Location do
  let(:location) { FactoryGirl.create :location_A }

  before :each do
    FactoryGirl.reload
  end

  it %q{should be active when it has a puzzle and that puzzle is active} do
    location.destination_for_puzzle.status = 'ready'
    location.active?.should be true
  end

  it %q{should not be active when it does not have a puzzle} do
    location.destination_for_puzzle = nil
    location.active?.should be false
  end

  it %q{should not be active when its puzzle is inactive} do
    location.destination_for_puzzle.status = 'wip'
    location.active?.should be false
  end
end

# ## Schema Information
#
# Table name: `locations`
#
# ### Columns
#
# Name                       | Type               | Attributes
# -------------------------- | ------------------ | ---------------------------
# **`id`**                   | `integer`          | `not null, primary key`
# **`address`**              | `string(255)`      |
# **`latitude`**             | `float`            |
# **`longitude`**            | `float`            |
# **`created_at`**           | `datetime`         | `not null`
# **`updated_at`**           | `datetime`         | `not null`
# **`name`**                 | `string(255)`      |
# **`token`**                | `string(255)`      |
# **`cluster_id`**           | `integer`          |
# **`permission_received`**  | `boolean`          |
# **`open_time`**            | `time`             |
# **`close_time`**           | `time`             |
# **`next_puzzle_id`**       | `integer`          |
#
