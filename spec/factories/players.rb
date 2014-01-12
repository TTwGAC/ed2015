FactoryGirl.define do
  factory :observer, class: Player do
    id 997
    first_name "Wanna"
    last_name  "Be"
    nickname "Puhleeeze"
    email "wanna@be.com"
    password "asdfghjl"
    team { Team.where(name: "Observers").first }
  end

  factory :player do
    id 998
    first_name "Flip"
    last_name  "Nelson"
    nickname "Backslash"
    email "flip@nelson.com"
    password "asdfghjl"
    team { FactoryGirl.build(:team) }
  end

  factory :admin, class: Player do
    id 999
    first_name "Tarzan"
    last_name  "Jungle"
    nickname "King of the Jungle"
    email "tarzan@jungle.com"
    password "asdfghjl"
    team { Team.where(name: "Game Control").first }
  end
end
