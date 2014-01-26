class AddNextPuzzleToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :next_puzzle_id, :integer
  end
end
