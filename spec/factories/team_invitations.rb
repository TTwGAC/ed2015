FactoryGirl.define do
  factory :team_invitation do |f|
    f.id 999
    f.email "jane@newyorkcity.us"
    f.team { FactoryGirl.build(:team) }
    f.token "1LK4" * 5
  end
end
