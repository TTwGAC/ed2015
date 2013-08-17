# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event, :class => 'Events' do
    player_id 1
    subject_type "MyString"
    subject_id 1
    action "MyString"
    description "MyString"
  end
end
