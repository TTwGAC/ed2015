# This will guess the User class
FactoryGirl.define do
  factory :user do
    id 1
    first_name "Tarzan"
    last_name  "Jungle"
    nickname "King of the Jungle"
    email "tarzan@jungle.com"
    password "asdfghjl"
  end

  factory :team do
    id 1
    name "Swinging Vines"
    slogan "We get you there in style"
    description "Tarzan, and friends"
  end
end
