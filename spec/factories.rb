# This will guess the User class
FactoryGirl.define do
  factory :user do
    first_name "Tarzan"
    last_name  "Jungle"
    nickname "King of the Jungle"
    email "tarzan@jungle.com"
    role "observer"
  end

  factory :team do
    name "Swinging Vines"
    slogan "We get you there in style"
    description "Tarzan, and friends"
  end
end