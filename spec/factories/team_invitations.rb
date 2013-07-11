FactoryGirl.define do
  factory :team_invitation do
    id 999
    email "jane@newyorkcity.us"
    team_id 999
    token "1LK4" * 5
  end
end
