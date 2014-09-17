FactoryGirl.define do
  factory :location do
    association :destination_for_puzzle, factory: :puzzle

    factory :location_A do
      name 'Location A'
      token 'a1b2c3d4'
      latitude -34.001
      longitude -87.501
      address 'Springfield, IL'
    end

    factory :location_B do
      name 'Location B'
      token '13112ld4'
      latitude 43.001
      longitude -57.501
      address 'New York, NY'
    end

    factory :location_C do
      name 'Location C'
      token 'pi3llz1h'
      latitude 13.001
      longitude -17.501
      address 'Chicago, IL'
    end

    factory :location_D do
      name 'Location D'
      token '1298uo12'
      latitude 0.0
      longitude 0.0
      address 'Knoxville, TN'
    end
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
