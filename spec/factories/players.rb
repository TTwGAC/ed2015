FactoryGirl.define do
  factory :observer, class: Player do
    id 997
    first_name "Wanna"
    last_name  "Be"
    nickname "Puhleeeze"
    email "wanna@be.com"
    password "asdfghjl"
    team Team.where(name: "Observers").first
    phone '14045551234'
  end

  factory :player do
    id 998
    first_name "Flip"
    last_name  "Nelson"
    nickname "Backslash"
    email "flip@nelson.com"
    password "asdfghjl"
    team
    phone '14045551235'
  end

  factory :admin, class: Player do
    id 999
    first_name "Tarzan"
    last_name  "Jungle"
    nickname "King of the Jungle"
    email "tarzan@jungle.com"
    password "asdfghjl"
    team Team.where(name: "Game Control").first
    phone '14045551236'
  end
end

# ## Schema Information
#
# Table name: `players`
#
# ### Columns
#
# Name                          | Type               | Attributes
# ----------------------------- | ------------------ | ---------------------------
# **`id`**                      | `integer`          | `not null, primary key`
# **`email`**                   | `string(255)`      | `default(""), not null`
# **`encrypted_password`**      | `string(255)`      | `default(""), not null`
# **`reset_password_token`**    | `string(255)`      |
# **`reset_password_sent_at`**  | `datetime`         |
# **`remember_created_at`**     | `datetime`         |
# **`sign_in_count`**           | `integer`          | `default(0)`
# **`current_sign_in_at`**      | `datetime`         |
# **`last_sign_in_at`**         | `datetime`         |
# **`current_sign_in_ip`**      | `string(255)`      |
# **`last_sign_in_ip`**         | `string(255)`      |
# **`created_at`**              | `datetime`         | `not null`
# **`updated_at`**              | `datetime`         | `not null`
# **`first_name`**              | `string(255)`      |
# **`last_name`**               | `string(255)`      |
# **`nickname`**                | `string(255)`      |
# **`created`**                 | `datetime`         |
# **`modified`**                | `datetime`         |
# **`role`**                    | `string(255)`      |
# **`team_id`**                 | `integer`          |
# **`confirmation_token`**      | `string(255)`      |
# **`confirmed_at`**            | `datetime`         |
# **`confirmation_sent_at`**    | `datetime`         |
# **`unconfirmed_email`**       | `string(255)`      |
# **`avatar`**                  | `string(255)`      |
# **`facebook_uid`**            | `string(255)`      |
# **`facebook_token`**          | `string(255)`      |
# **`twitter_uid`**             | `string(255)`      |
# **`twitter_token`**           | `string(255)`      |
# **`twitter_secret`**          | `string(255)`      |
# **`twitter_handle`**          | `string(255)`      |
# **`phone`**                   | `string(255)`      |
#
# ### Indexes
#
# * `index_users_on_confirmation_token` (_unique_):
#     * **`confirmation_token`**
# * `index_users_on_email` (_unique_):
#     * **`email`**
# * `index_users_on_reset_password_token` (_unique_):
#     * **`reset_password_token`**
#
