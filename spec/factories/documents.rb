# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :document do
    name "MyString"
    description "MyText"
    private false
  end
end

# ## Schema Information
#
# Table name: `documents`
#
# ### Columns
#
# Name                     | Type               | Attributes
# ------------------------ | ------------------ | ---------------------------
# **`id`**                 | `integer`          | `not null, primary key`
# **`name`**               | `string(255)`      |
# **`description`**        | `text`             |
# **`token`**              | `string(255)`      | `not null`
# **`private`**            | `boolean`          |
# **`file`**               | `string(255)`      |
# **`documentable_id`**    | `integer`          |
# **`documentable_type`**  | `string(255)`      |
# **`created_at`**         | `datetime`         | `not null`
# **`updated_at`**         | `datetime`         | `not null`
#
