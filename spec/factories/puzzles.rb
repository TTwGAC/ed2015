# encoding: utf-8

FactoryGirl.define do
  factory :puzzle do
    sequence(:name) { |n| "Puzzle ##{n}" }
    status 'ready'
    open true
  end
end

