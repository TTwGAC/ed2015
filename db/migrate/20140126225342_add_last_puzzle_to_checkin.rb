class AddLastPuzzleToCheckin < ActiveRecord::Migration
  def change
    add_column :checkins, :solved_puzzle_id, :integer
    add_column :checkins, :next_puzzle_id, :integer
  end
end
