# This will guess the User class
FactoryGirl.define do
  factory :player do
    id 999
    first_name "Tarzan"
    last_name  "Jungle"
    nickname "King of the Jungle"
    email "tarzan@jungle.com"
    password "asdfghjl"
    team { FactoryGirl.build(:team) }
  end

  factory :team do
    id 999
    name "Swinging Vines"
    slogan "We get you there in style"
    description "Tarzan, and friends"
    token "ABCD" * 5
  end
end
