class MoveOriginKeysFromPuzzleToLocation < ActiveRecord::Migration
  def up
    Puzzle.all.each do |p|
      if location = p.origin
        location.next_puzzle = p
        location.save!
        p.origin = nil
        p.save!
      end
    end
  end

  def down
    Location.all.each do |l|
      if puzzle = l.next_puzzle
        puzzle.origin = l
        puzzle.save!
        l.next_puzzle = nil
        l.save!
      end
    end
  end
end
