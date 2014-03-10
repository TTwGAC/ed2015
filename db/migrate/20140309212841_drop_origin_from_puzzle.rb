class DropOriginFromPuzzle < ActiveRecord::Migration
  def change
    remove_column :puzzles, :origin_id
  end
end
