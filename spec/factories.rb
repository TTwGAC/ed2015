# This will guess the User class
FactoryGirl.define do
  factory :team do
    id 999
    name "Swinging Vines"
    slogan "We get you there in style"
    description "Tarzan, and friends"
    token "ABCD" * 5
    phone "14045551234"
  end

  factory :otherteam, class: Team do
    id 998
    name "Urbana-nana"
    slogan "You'll split for us"
    description "Illinois? What's that noise?"
    token "ABCD" * 5
    phone "14045551234"
  end
end
