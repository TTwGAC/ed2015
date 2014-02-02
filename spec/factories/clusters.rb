# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cluster do
    sequence :sequence
    sequence(:name)  { |n| "#{Cluster::COLORS[n].capitalize} Cluster" }
    sequence(:color) { |n| Cluster::COLORS[n] }
  end
end
