require 'spec_helper'

describe Puzzle do
  pending "add some examples to (or delete) #{__FILE__}"
end

# ## Schema Information
#
# Table name: `puzzles`
#
# ### Columns
#
# Name                   | Type               | Attributes
# ---------------------- | ------------------ | ---------------------------
# **`id`**               | `integer`          | `not null, primary key`
# **`name`**             | `string(255)`      |
# **`destination_id`**   | `integer`          |
# **`created_at`**       | `datetime`         | `not null`
# **`updated_at`**       | `datetime`         | `not null`
# **`token`**            | `string(255)`      |
# **`description`**      | `text`             |
# **`status`**           | `string(255)`      |
# **`flavortext`**       | `text`             |
# **`expected_ttc`**     | `integer`          |
# **`owner_id`**         | `integer`          |
# **`open`**             | `boolean`          |
# **`include_bearing`**  | `boolean`          |
#
