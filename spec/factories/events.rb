# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event, :class => 'Events' do
    player_id 1
    subject_type "MyString"
    subject_id 1
    action "MyString"
    description "MyString"
  end
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
