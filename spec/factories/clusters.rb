# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cluster do
    sequence :sequence
    sequence(:name)  { |n| "#{Cluster::COLORS[n].capitalize} Cluster" }
    sequence(:color) { |n| Cluster::COLORS[n] }
  end
end

# ## Schema Information
#
# Table name: `clusters`
#
# ### Columns
#
# Name              | Type               | Attributes
# ----------------- | ------------------ | ---------------------------
# **`id`**          | `integer`          | `not null, primary key`
# **`name`**        | `string(255)`      |
# **`sequence`**    | `integer`          |
# **`color`**       | `string(255)`      | `default("red")`
# **`created_at`**  | `datetime`         | `not null`
# **`updated_at`**  | `datetime`         | `not null`
#
