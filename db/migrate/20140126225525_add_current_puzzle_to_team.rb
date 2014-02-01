class AddCurrentPuzzleToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :current_puzzle_id, :integer
  end
end
