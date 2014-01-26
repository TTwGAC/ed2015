# encoding: utf-8

FactoryGirl.define do
  factory :unattached_puzzle, class: Puzzle do
    id 1
    name "Unattached Puzzle"
  end

  factory :puzzle_ending_at_A, class: Puzzle do
    id 2
    name "Puzzle ending at A"
    destination { FactoryGirl.build :location_A }
  end

  factory :puzzle_ending_at_B, class: Puzzle do
    id 3
    name "Puzzle ending at B"
    destination { FactoryGirl.build :location_B }
  end

  factory :puzzle_ending_at_C, class: Puzzle do
    id 3
    name "Puzzle ending at C"
    destination { FactoryGirl.build :location_C }
  end
end

