# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :blue_cluster, class: Cluster do
    name 'Blue Cluster'
    add_attribute :sequence, 1
    add_attribute :color, 'blue'
  end
end
